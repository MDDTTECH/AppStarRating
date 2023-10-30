//
//  RateView.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 28.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit
import Blurberry


public final class RateView: UIVisualEffectView {
    
    public typealias SelectedStarHandler = ((StarRate) -> Void)
    public typealias StarRate = (selectedStar: Int, ofTotalStars: Int)
    public typealias TapCloseHandler = () -> Void
    public typealias TapSendRateHandler = (StarRate) -> Void
    public typealias Suggestions = (selectedStar: Int, ofTotalStars: Int, suggestions: String)
    public typealias SendSuggestionsHandler = ((Suggestions) -> Void)
    
    // MARK: Internal Properties
    
    // MARK: Private Properties
    private let styles: Styles
    private let selectedStarHandler: SelectedStarHandler
    private let tapCloseHandler: TapCloseHandler
    private let tapSendRateHandler: TapSendRateHandler
    private let sendSuggestionsHandler: SendSuggestionsHandler
    private let appUrl: AppUrl
    private var starRate: StarRate
    private lazy var rateService: RateServicable? = RateService()
    
    private lazy var rateStarView: RateUsView = {
        
        let rate = RateUsView(
            styles: styles,
            tapCloseHandler: tapCloseHandler,
            tapSendRateHandler: { [weak self] starRate in
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
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

private extension RateView {
    
    func setupRateStarView() {
        self.contentView.addSubview(rateStarView)
        
        rateStarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(190)
                
        }
    }
    
    func setupAppearence() {
        
        self.backgroundColor = styles.blurColor
        self.blur.radius = styles.blurRadius
        
    }
    
    func setupSuggestionsView() {
        self.contentView.addSubview(suggestionsView)
        
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
        if starRate.selectedStar == starRate.ofTotalStars{
            rateService?.rateApp(with: starRate, appUrl: appUrl)
            tapCloseHandler()
        } else if starRate.selectedStar > 0 {
            rateStarView.removeFromSuperview()
            setupSuggestionsView()
        }
    }
    
}
