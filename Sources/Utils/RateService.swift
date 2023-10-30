//
//  RateService.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 26.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import Foundation


protocol RateServicable {
    func rateApp(
        with rate: RateView.StarRate,
        appUrl: AppUrl
    )
    
    func sendSuggestions(
        with feedback: String,
        rating: Int
    )
}


final class RateService {}

extension RateService: RateServicable {
    
    func rateApp(
        with rate: RateView.StarRate,
        appUrl: AppUrl
    ) {
        
        if rate.selectedStar == rate.ofTotalStars{
            AppStoreManager.requestReviewIfAppropriate(with: appUrl)
        }// TODO: Save other rate in smwhere?
    }
    
    
    func sendSuggestions(
        with feedback: String,
        rating: Int
    ) {
        
        
        
    }
}
    
