//
//  RateView.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 28.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import Combine
import UIKit
import Blurberry


public final class RateView: UIVisualEffectView {
    
    /// Detect on which stage rate or suggestion user tap close or that the same  blur
    ///  If user close on rate stage so user don't whant to rate and if on suggestion so user have rated but don't whant to write suggestion
    public enum CloseExecutor {
        case rate
        case suggestions
    }
    
    public typealias SelectedStarHandler = ((StarRate) -> Void)
    public typealias StarRate = (selectedStar: Int, ofTotalStars: Int)
    public typealias TapCloseHandler = (CloseExecutor) -> Void
    public typealias TapSendRateHandler = (StarRate) -> Void
    public typealias Suggestions = (selectedStar: Int, ofTotalStars: Int, suggestions: String)
    public typealias SendSuggestionsHandler = ((Suggestions) -> Void)
    
    // MARK: Internal Properties
    
    // MARK: Private Properties
    private var currentStage: CloseExecutor = .rate
    private let styles: Styles
    private let selectedStarHandler: SelectedStarHandler
    private let tapCloseHandler: TapCloseHandler
    private let tapSendRateHandler: TapSendRateHandler
    private let sendSuggestionsHandler: SendSuggestionsHandler
    private let appUrl: AppUrl
    private var starRate: StarRate
    private lazy var rateService: RateServicable? = RateService()
    private var isKeyboardShown = false
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var rateStarView: RateUsView = {
        
        let rate = RateUsView(
            styles: styles,
            tapCloseHandler: { [weak self] executor in
                #if DEBUG
                print(" [AppStarRate.RateView] tapCloseHandler \(executor) ")
                #endif
                self?.subviews.forEach { $0.removeFromSuperview() }
                self?.tapCloseHandler(executor)
            },
            tapSendRateHandler: { [weak self] starRate in
                #if DEBUG
                print(" [AppStarRate.RateView] tapSendRateHandler send rate: \(starRate.selectedStar), out of \(starRate.ofTotalStars)")
                #endif
                self?.onSendRateTapped(starRate: starRate)
            }
        )
        return rate
        
    }()
    
    private lazy var suggestionsView: SuggestionsView = {
        
        let view = SuggestionsView(
            styles: styles,
            starRate: starRate,
            tapCloseHandler: tapCloseHandler,
            sendSuggestionsHandler: sendSuggestionsHandler
        )
        
        return view
        
    }()
    
    // MARK: Init
    public init(
        styles: Styles = .default,
        appUrl: AppUrl,
        selectedStarHandler: @escaping SelectedStarHandler,
        tapCloseHandler: @escaping TapCloseHandler,
        tapSendRateHandler: @escaping TapSendRateHandler,
        sendSuggestionsHandler: @escaping SendSuggestionsHandler
    ) {
        self.styles = styles
        self.starRate = (selectedStar: 0, ofTotalStars: styles.totalStarsRate)
        self.appUrl = appUrl
        self.selectedStarHandler = selectedStarHandler
        self.tapCloseHandler = tapCloseHandler
        self.tapSendRateHandler = tapSendRateHandler
        self.sendSuggestionsHandler = sendSuggestionsHandler
        super.init(effect: UIBlurEffect(style: .dark))
        
        setupRateStarView()
        setupAppearence()
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in
                self?.isKeyboardShown = true
            }
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isKeyboardShown = false
            }
            .store(in: &cancellables)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.endEditing(true)
    }
}

private extension RateView {
    
    func setupRateStarView() {
        self.contentView.addSubview(rateStarView)
        rateStarView.addGestureRecognizer(UITapGestureRecognizer(target: nil, action: nil))
        
        rateStarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(190)
        }
    }
    
    func setupAppearence() {
        self.backgroundColor = styles.blurColor
        self.blur.radius = styles.blurRadius
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBlurViewTapped)))
    }
    
    func setupSuggestionsView() {
        self.contentView.addSubview(suggestionsView)
        suggestionsView.addGestureRecognizer(UITapGestureRecognizer(target: nil, action: nil))
        currentStage = .suggestions
        suggestionsView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(463)
        }
    }
}

private extension RateView {
    
    func onSendRateTapped(starRate: StarRate) {
        self.starRate = starRate
        tapSendRateHandler(starRate)
        if starRate.selectedStar == starRate.ofTotalStars{
            rateService?.rateApp(with: starRate, appUrl: appUrl)
            tapCloseHandler(.rate)
        } else if starRate.selectedStar > 0 {
            rateStarView.removeFromSuperview()
            setupSuggestionsView()
        }
    }
    
    @objc
    func onBlurViewTapped() {
        guard !isKeyboardShown else { return }
        
        tapCloseHandler(currentStage)
    }
}
