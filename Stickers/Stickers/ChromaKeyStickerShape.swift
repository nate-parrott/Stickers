//
//  ChromaKeyStickerShape.swift
//  Stickers
//
//  Created by Nate Parrott on 6/19/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class ChromaKeyStickerShape: StickerShape {
    var _chromaKey: GPUImageChromaKeyFilter?
    var _mask: GPUImageMaskFilter?
    let picture = GPUImagePicture(image: UIImage(named: "SquareMask")!)!
    override func createFilterChain(input: GPUImageOutput) -> GPUImageOutput! {
        if _chromaKey == nil {
            _chromaKey = GPUImageChromaKeyFilter()
            _chromaKey!.smoothing = 0
        }
        input.addTarget(_chromaKey!)
        if _mask == nil {
            _mask = GPUImageMaskFilter()
            _chromaKey!.addTarget(_mask!)
            picture.addTarget(_mask!)
            picture.processImage()
        }
        return _mask!
    }
}
