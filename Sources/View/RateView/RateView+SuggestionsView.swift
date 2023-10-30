
//
//  RateView+SuggestionsView.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 28.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit
import SnapKit

public extension RateView {
    
    final class SuggestionsView: UIView {
        
        // MARK: Internal Properties
        
        // MARK: Private Properties
        private let styles: Styles
        private var starRate: StarRate
//        private var message: String?
        private let tapCloseHandler: TapCloseHandler
        private let sendSuggestionsHandler: SendSuggestionsHandler
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            // TODO: Localization
            label.text = "Поделись мнением"
            return label
        }()
        
        private lazy var subTitleLabel: UILabel = {
            let label = UILabel()
            // TODO: Localization
            label.text = """
                Пожалуйста, расскажи о своих
                впечатлениях от использования
                приложения
                """
            label.textAlignment = .center
            label.numberOfLines = 3
            return label
        }()
        
        private lazy var closeButton: UIButton = {
            let button = UIButton()
            let img: UIImage = styles.closeButtonImage ?? UIImage(systemName: "xmark") ?? UIImage()
                                                                  
            button.setImage(img, for: .normal)
            button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
            
                                                                    return button
        }()
        
        private lazy var suggestionTextFiled: UITextField = {
            let tf = UITextField()
            tf.backgroundColor = .lightGray.withAlphaComponent(0.5)
            tf.textAlignment = .natural
            tf.leftView = UIView()
            return tf
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
            starRate: StarRate,
            tapCloseHandler: @escaping TapCloseHandler,
            sendSuggestionsHandler: @escaping SendSuggestionsHandler
        ) {
            self.styles = styles
            self.starRate = starRate
            self.tapCloseHandler = tapCloseHandler
            self.sendSuggestionsHandler = sendSuggestionsHandler
            super.init(frame: .zero)
            
            setupLayout()
            setupAppearance()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}

private extension RateView.SuggestionsView {
    
    func setupLayout() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.top.trailing.equalToSuperview().inset(18)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(37)
            make.height.equalTo(18)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.height.equalTo(60)
        }
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        addSubview(suggestionTextFiled)
        suggestionTextFiled.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.bottom.equalTo(sendButton.snp.top).inset(19)
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
        layer.masksToBounds = true
        
        titleLabel.font = styles.fonts.title
        subTitleLabel.font = styles.fonts.subtitle
        suggestionTextFiled.font = styles.fonts.message
        suggestionTextFiled.textColor = styles.colors.messageColor
        suggestionTextFiled.placeholder = "Сообщение"
        sendButton.titleLabel?.font = styles.fonts.sendButtonTitle
        sendButton.setTitleColor(styles.colors.titleColor, for: .normal)
        
    }
    
    @objc
    func closeButtonAction(_ sender: UIButton) {
        tapCloseHandler()
    }
    
    @objc
    func sendAction(_ sender: UIButton) {
        print("send rate: \(starRate.selectedStar), out of \(starRate.ofTotalStars)")
        
        sendSuggestionsHandler((
            selectedStar: starRate.selectedStar,
            ofTotalStars: starRate.ofTotalStars,
            suggestions: suggestionTextFiled.text ?? ""
        ))
    }
}

