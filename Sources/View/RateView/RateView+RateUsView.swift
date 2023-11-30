
//
//  RateView+RateUsView.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 28.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit
import SnapKit

public extension RateView {
    
    final class RateUsView: UIView {
        
        // MARK: Internal Properties
        
        // MARK: Private Properties
        private let styles: Styles
        private var starRate: StarRate = (0, 5)
        private let tapCloseHandler: TapCloseHandler
        private let tapSendRateHandler: TapSendRateHandler
        
        private lazy var rateUsLabel: UILabel = {
            let label = UILabel()
            // TODO: Localization
            label.text = "Оцени нас!"
            return label
        }()
        
        private lazy var closeButton: UIButton = {
            let button = UIButton()
            let img: UIImage = styles.closeButtonImage ?? UIImage(systemName: "xmark") ?? UIImage()
            
            button.setImage(img, for: .normal)
            button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
            
            return button
        }()
        
        private lazy var starRatingView: StarRating = {
            let control = StarRating(frame: .zero, styles: styles, selectedStars: 0)
            control.addTarget(self, action: #selector(starRatingValueChanged(_:)), for: .valueChanged)
            return control
        }()
        
        private lazy var sendButton: SendButton = {
            let button = SendButton(cornerRadius: styles.cornerRadius)            // TODO: Localization
            button.setTitle("Отправить", for: .normal)
            //FIXME: dont worked with style
            button.backgroundColor = .green //styles.colors.sendButtonColor
            button.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
            button.isUserInteractionEnabled = true
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        // MARK: Init
        
        init(
            styles: Styles,
            tapCloseHandler: @escaping TapCloseHandler,
            tapSendRateHandler: @escaping TapSendRateHandler
        ) {
            self.styles = styles
            self.tapCloseHandler = tapCloseHandler
            self.tapSendRateHandler = tapSendRateHandler
            super.init(frame: .zero)
            
            setupLayout()
            setupAppearance()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}

private extension RateView.RateUsView {
    
    func setupLayout() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.top.trailing.equalToSuperview().inset(18)
        }
        
        addSubview(rateUsLabel)
        rateUsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(37)
            make.height.equalTo(18)
        }
        
        addSubview(starRatingView)
        starRatingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(29)
        }
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupAppearance() {
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = styles.cornerRadius
        
        rateUsLabel.font = styles.fonts.title
        sendButton.titleLabel?.font = styles.fonts.sendButtonTitle
        sendButton.setTitleColor(styles.colors.titleColor, for: .normal)
        
        closeButton.isHidden = !styles.isCloseButtonVisible
    }
    
    @objc
    func closeButtonAction(_ sender: UIButton) {
        tapCloseHandler(.rate)
    }
    
    @objc
    func sendAction(_ sender: UIButton) {
        print(" [AppStarRate.RateUsView] sendAction \(sender) send rate: \(starRate.selectedStar), out of \(starRate.ofTotalStars)")
        tapSendRateHandler((starRate.selectedStar, starRate.ofTotalStars))
        tapSendRateHandler((starRate.selectedStar, starRate.ofTotalStars))
    }
    
    @objc
    func starRatingValueChanged(_ sender: RateView.StarRating) {
        
        print("Selected \(sender.selectedStars), out of \(sender.totalStars)")
        starRate = (sender.selectedStars, sender.totalStars)

    }
}
