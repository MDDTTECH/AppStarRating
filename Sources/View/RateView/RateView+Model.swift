//
//  RateView+Model.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 28.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit

public extension RateView {
    
    struct Styles {
        public let isCloseButtonVisible: Bool
        
        public struct Fonts {
            public let title: UIFont
            public let subtitle: UIFont
            public let placeholder: UIFont
            public let message: UIFont
            public let sendButtonTitle: UIFont
            
            public init(title: UIFont, subtitle: UIFont, placeholder: UIFont, message: UIFont, sendButtonTitle: UIFont) {
                self.title = title
                self.subtitle = subtitle
                self.placeholder = placeholder
                self.message = message
                self.sendButtonTitle = sendButtonTitle
            }
        }
        
        public struct Colors {
            public let starColor: UIColor
            public let sendButtonColor: UIColor
            public let titleColor: UIColor
            public let subtitleColor: UIColor
            public let placeholderColor: UIColor
            public let messageColor: UIColor
            public let blurColor: UIColor
            public let closeButtonClolor: UIColor
            
            public init(starColor: UIColor, sendButtonColor: UIColor, titleColor: UIColor, subtitleColor: UIColor, placeholderColor: UIColor, messageColor: UIColor, blurColor: UIColor, closeButtonClolor: UIColor) {
                self.starColor = starColor
                self.sendButtonColor = sendButtonColor
                self.titleColor = titleColor
                self.subtitleColor = subtitleColor
                self.placeholderColor = placeholderColor
                self.messageColor = messageColor
                self.blurColor = blurColor
                self.closeButtonClolor = closeButtonClolor
            }
        }
        
//        public struct Shadow {
//            let color: UIColor
//            let blurRadius: CGFloat
//            let offset: CGSize
//        }
        
        public let fonts: Fonts
        public let colors: Colors
        public let blurColor: UIColor
        public let blurRadius: CGFloat
        public let cornerRadius: CGFloat
        public let totalStarsRate: Int
        public let closeButtonImage: UIImage?
        public let filledStarImage: UIImage?
        public let unfilledStarImage: UIImage?
        
        public init(isCloseButtonVisible: Bool, fonts: Fonts, colors: Colors, blurColor: UIColor, blurRadius: CGFloat, cornerRadius: CGFloat, totalStarsRate: Int, closeButtonImage: UIImage?, filledStarImage: UIImage?, unfilledStarImage: UIImage?) {
            self.isCloseButtonVisible = isCloseButtonVisible
            self.fonts = fonts
            self.colors = colors
            self.blurColor = blurColor
            self.blurRadius = blurRadius
            self.cornerRadius = cornerRadius
            self.totalStarsRate = totalStarsRate
            self.closeButtonImage = closeButtonImage
            self.filledStarImage = filledStarImage
            self.unfilledStarImage = unfilledStarImage
        }

        
        public static var `default`: Self {
            return .init(
                isCloseButtonVisible: true,
                fonts: .init(
                    title: .boldSystemFont(ofSize: 18),
                    subtitle: .systemFont(ofSize: 14),
                    placeholder: .systemFont(ofSize: 16),
                    message: .systemFont(ofSize: 16),
                    sendButtonTitle: .systemFont(ofSize: 14)
                ),
                colors: .init(
                    starColor: UIColor(red: 33, green: 251, blue: 42, alpha: 1),
                    sendButtonColor: UIColor(red: 33, green: 251, blue: 42, alpha: 1),
                    titleColor: .black,
                    subtitleColor: UIColor(red: 42, green: 33, blue: 23, alpha: 1),
                    placeholderColor: .gray,
                    messageColor: .black,
                    blurColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1),
                    closeButtonClolor: .gray
                ),
//                shadow: .init(color: .clear, blurRadius: 0, offset: .zero),
                /*
                shadow: .init(
                    color: UIColor.black.withAlphaComponent(0.1),
                    blurRadius: 16,
                    offset: .init(width: 0, height: 8)
                ),
                 */
                
                blurColor: .init(red: 0, green: 0, blue: 0, alpha: 0.9),
                blurRadius: 1.0,
                cornerRadius: 0,
                totalStarsRate: 5,
                closeButtonImage: .init(systemName: "xmark") ?? UIImage(),
                filledStarImage: .init(systemName: "star.fill") ?? UIImage(),
                unfilledStarImage: .init(systemName: "star") ?? UIImage()
            )
        }
    }
}
