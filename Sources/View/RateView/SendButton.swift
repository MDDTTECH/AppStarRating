//
//  SendButton.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 30.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit

class SendButton: UIButton {
    init() {
        super.init(frame: .zero)
        addTapsAnimations()
    }
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        addTapsAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTouchDown() {
        animateButtonDown()
    }
    
    @objc
    private func didTouchUpOutside() {
        animateButtonUp()
    }
    
    @objc
    private func didTouchUpInside() {
        animateButtonUp()
    }
    
    private func animateButtonDown() {
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: nil)
    }

    private func animateButtonUp() {
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: [.allowUserInteraction, .curveEaseOut],
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.identity
                       },
                       completion: nil)
    }
}

extension SendButton {
    private func addTapsAnimations() {
        addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        addTarget(self, action: #selector(didTouchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
}

