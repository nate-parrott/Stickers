//
//  UIImage+Resize.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit

extension UIImage {
    func resized(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image(actions: { (context) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        })
    }
    func resized(maxDimension: CGFloat) -> UIImage {
        let scale = min(1, min(maxDimension / size.width, maxDimension / size.height))
        return resized(size: CGSize(width: round(size.width * scale), height: round(size.height * scale)))
    }
}
