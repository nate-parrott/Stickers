//
//  BorderFilter.swift
//  Stickers
//
//  Created by Nate Parrott on 6/19/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class BorderFilter: GPUImageTwoPassTextureSamplingFilter {
    override init() {
        super.init(vertexShaderFrom: kGPUImageDilationRadiusFourVertexShaderString, fragmentShaderFrom: try! String(contentsOf: Bundle.main().urlForResource("BorderFilter", withExtension: "fsh")!))
    }
}
