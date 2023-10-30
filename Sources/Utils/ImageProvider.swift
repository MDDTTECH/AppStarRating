//
//  ImageProvider.swift
//  MDDTStarRating
//
//  Created by Aleksunder Volkov on 26.10.2023.
//  Copyright © 2023 MDDT. All rights reserved.
//

import UIKit

public class ImageProvider {

    public static func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle(for: self), with: nil) ?? UIImage()
        
    }
}
