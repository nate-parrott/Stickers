//
//  StickerCapturePipeline.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class StickerCapturePipeline {
    init(source: ImageSource, shape: StickerShape, outputView: GPUImageView) {
        source.imageOutput.forceProcessing(atSizeRespectingAspectRatio: CGSize(width: 400, height: 400))
        crop = GPUImageCropFilter(cropRegion: source.outputSize.squareCropUnitRect)
        let dilate = GPUImageRGBDilationFilter(radius: 4)!
        let brightness = GPUImageBrightnessFilter()
        let scale = GPUImageTransformFilter()
        scale.affineTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        brightness.brightness = 1
        let blend1 = GPUImageNormalBlendFilter()
        let blend2 = GPUImageNormalBlendFilter()
        let darkness = GPUImageBrightnessFilter()
        darkness.brightness = 0
        let blur = GPUImageGaussianBlurFilter()
        blur.blurRadiusAsFractionOfImageWidth = 0.02
        let drop = GPUImageTransformFilter()
        drop.affineTransform = CGAffineTransform(translationX: 0, y: 0.01)
        
        self.source = source
        self.shape = shape
        source.imageOutput.addTarget(crop)
        output = shape.createFilterChain(input: crop)
        
        output.addTarget(scale)
        scale.addTarget(dilate)
        
        scale.addTarget(darkness)
        darkness.addTarget(blur)
        blur.addTarget(drop)
        
        dilate.addTarget(brightness)
        
        drop.addTarget(blend1)
        brightness.addTarget(blend1)
        blend1.addTarget(blend2)
        scale.addTarget(blend2)
        
        blend2.addTarget(outputView)
        
        source.pushFrame()
    }
    let source: ImageSource
    let shape: StickerShape
    let crop: GPUImageCropFilter
    let output: GPUImageOutput
    func cleanUp() {
        source.imageOutput.removeAllTargets()
        source.cleanUp()
        crop.removeAllTargets()
        output.removeAllTargets()
    }
}

extension CGSize {
    var squareCropUnitRect: CGRect {
        get {
            let size = min(width, height)
            let cropRect = CGRect(x: (width - size)/2, y: (height - size)/2, width: size, height: size)
            return CGRect(x: cropRect.origin.x / width, y: cropRect.origin.y / height, width: cropRect.size.width / width, height: cropRect.size.height / height)
        }
    }
}
