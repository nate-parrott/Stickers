//
//  MaskImageStickerShape.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class MaskImageStickerShape: StickerShape {
    init(mask: UIImage, title: String, iconName: String?) {
        picture = GPUImagePicture(image: mask)
        super.init(title: title, iconName: iconName)
    }
    let picture: GPUImagePicture
    override func createFilterChain(input: GPUImageOutput) -> GPUImageOutput! {
        let maskFilter = GPUImageMaskFilter()
        input.addTarget(maskFilter, atTextureLocation: 0)
        picture.removeAllTargets()
        picture.addTarget(maskFilter, atTextureLocation: 1)
        picture.processImage()
        return maskFilter
    }
}
