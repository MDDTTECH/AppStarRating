//
//  AppStoreManager.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 26.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import StoreKit

public typealias AppUrl = String

public enum AppStoreManager {
    static func requestReviewIfAppropriate(with appUrl: AppUrl) {
        //Decide how we will rate the app?
        //        if let windowScene = self?.view.window?.windowScene {
        //            SKStoreReviewController.requestReview(in: windowScene)
        //        }
        guard let writeReviewURL = URL(string: "\(appUrl)?action=write-review") else { return }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
