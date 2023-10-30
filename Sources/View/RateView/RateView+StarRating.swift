
//
//  StarRating.swift
//  TrueAvatar-iOS
//
//  Created by Волков Александр on 25.09.2022.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit
import SnapKit

public extension RateView {
    
    final class StarRating: UIControl {
        
        
        var styles: Styles = .default
        
        /// Number of total stars
        lazy var totalStars: Int = 5
        
        /// Number of selected stars
        lazy var selectedStars: Int = 1 {
            didSet {
                showStarRating()
            }
        }
        
        /// A layout container view to hold and layout stars
        lazy var starStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            stackView.isUserInteractionEnabled = false
            return stackView
        }()
        
        /// Initialize StarRating view with default values of Total Stars and Selected Stars
        /// - Parameter frame: frame of the view
        convenience override init(frame: CGRect) {
            self.init(frame: frame, styles: .default, selectedStars: 0)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            // Loading Star View when initialized from Storyboard
            loadStarRating()
        }
        
        /// Initialize StarRating view with custom values of Total Stars and Selected Stars
        /// - Parameters:
        ///   - frame: frame of the view
        ///   - totalStars: Number of total stars
        ///   - selectedStars: Number of selected stars
        init(frame: CGRect, styles: Styles, selectedStars: Int) {
            guard (3...10).contains(styles.totalStarsRate) else {
                fatalError("Please specify total stars value within the range of 3 to 10")
            }
            super.init(frame: frame)
            loadStarRating()
            self.styles = styles
            self.totalStars = styles.totalStarsRate
            self.selectedStars = selectedStars
        }
        
    }
}

// MARK: - UI Methods
extension RateView.StarRating {
    
    /// Load and layout Star View
    private func loadStarRating() {
        // Add and layout starStackView
        addSubview(starStackView)
        starStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        // Making this element Accessible
        isAccessibilityElement = true
    }
    
    /// Show and update Stars
    private func showStarRating() {
        for i in 0..<totalStars {
            let starImage: UIImage = i < selectedStars ? 
            (styles.filledStarImage ?? .init(systemName: "star.fill") ?? UIImage()) :
            styles.unfilledStarImage ?? .init(systemName: "star") ?? UIImage()
            if i < starStackView.arrangedSubviews.count,
               let starImageView = starStackView.arrangedSubviews[i] as? UIImageView {
                // Update star image
                starImageView.image = starImage
            } else {
                // Add star image
                let starImageView = UIImageView(image: starImage)
                starImageView.contentMode = .scaleAspectFit
                starStackView.addArrangedSubview(starImageView)
            }
        }
        
        // Setting Accessibility description for VoiceOver
        accessibilityLabel = "\(selectedStars) stars selected out of \(totalStars)"
        
        // Set value change event action
        sendActions(for: .valueChanged)
    }
    
}

// MARK: - Selector methods for touch gesture handler
extension RateView.StarRating {
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        /// `X` Position of user touch within the Star View's bounds
        let xPosition = touch.location(in: self).x
        /// Calculate new selected stars based on the xPosition
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var xPosition:CGFloat = 0
        
        xPosition += touch.location(in: self).x
        
        if xPosition < 0 {
            /// Maintaining lowest possible value
            xPosition = 0
        }
        
        if xPosition > bounds.maxX {
            /// Maintaining highest possible value
            xPosition = bounds.maxX
        }
        
        calculateNewStars(basedOn: xPosition)
        return true
    }
    
    private func calculateNewStars(basedOn position: CGFloat) {
        /// Based on the position to width ratio calculating selected stars from total stars.
        /// Example: User taps on 2/3 part of the star view which gives us 2/3 of the total stars. Rounding it to whole number gives us Selected Stars.
        /// `2/3 * 5(total stars) = 3.33 =~ 4(selected stars)`
        let newSelectedStars = Int(ceil(position / bounds.width * CGFloat(totalStars)))
        
        // Update selected stars only when newly selected is different than the old value
        if newSelectedStars != selectedStars {
            selectedStars = newSelectedStars
        }
    }
    
}
