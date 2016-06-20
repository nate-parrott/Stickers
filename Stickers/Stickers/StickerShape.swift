//
//  StickerShape.swift
//  Stickers
//
//  Created by Nate Parrott on 6/16/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class StickerShape: NSObject, StylePickerItem {
    static let AllShapes: [StickerShape] = [
        MaskImageStickerShape(mask: UIImage(named: "CircleMask")!, title: "Circle", iconName: "Circle"),
        MaskImageStickerShape(mask: UIImage(named: "SquareMask")!, title: "Square", iconName: "Square"),
        MaskImageStickerShape(mask: UIImage(named: "DiamondMask")!, title: "Diamond", iconName: "Diamond"),
        ChromaKeyStickerShape(title: "Green Screen", iconName: "Greenscreen")
    ]
    
    init(title: String, iconName: String?) {
        self.title = title
        self.iconName = iconName
    }
    let title: String
    let iconName: String?
    func createFilterChain(input: GPUImageOutput) -> GPUImageOutput! {
        return nil
    }
}
