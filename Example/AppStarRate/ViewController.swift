//
//  ViewController.swift
//  StarRatingExample
//
//  Created by Aleksunder Volkov on 26.10.2023.
//

import UIKit
import AppStarRate

class ViewController: UIViewController {
    
    private lazy var rateView: RateView = {
        let styles: RateView.Styles = .init(
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
            blurColor: .init(red: 0, green: 0, blue: 0, alpha: 0.9),
            blurRadius: 1.0,
            cornerRadius: 0,
            totalStarsRate: 5,
            closeButtonImage: UIImage(
                named: "CloseIcon",
                in: Bundle(for: Self.self),
                with: nil
            ),
            filledStarImage: UIImage(
                named: "FilledStarIcon",
                in: Bundle(for: Self.self),
                with: nil
            ),
            unfilledStarImage: UIImage(
                named: "EmptyStarIcon",
                in: Bundle(for: Self.self),
                with: nil
            )
        )
        let view = RateView (
            styles: styles,
            appUrl: "https://apps.apple.com/us/app/irnby/id1484553613"
        ){ starRate in
            print("selected \(starRate.selectedStar)")
        } tapCloseHandler: {
            print("tapedClose")
            self.rateView.removeFromSuperview()
        } tapSendRateHandler: { starRate in
            print("send starRate \(starRate.selectedStar) of: \(starRate.ofTotalStars)")
        } sendSuggestionsHandler: { suggestions in
            print("send suggestions: \(suggestions.selectedStar) of: \(suggestions.ofTotalStars) and message: \(suggestions.suggestions)")
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIImageView(image: UIImage(named: "test"))
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(rateView)
        
        rateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Do any additional setup after loading the view.
    }


}

