//
//  ImageSource.swift
//  Stickers
//
//  Created by Nate Parrott on 6/16/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class ImageSource: NSObject {
    static let AllSources: [ImageSource] = [
        StillImageSource(),
        CameraImageSource(position: .front),
        CameraImageSource(position: .back)
    ]
    
    override init() {
        super.init()
    }
    var imageOutput: GPUImageOutput! {
        get {
            return nil
        }
    }
    var outputSize: CGSize {
        get {
            return CGSize.zero
        }
    }
    func cleanUp() {
        
    }
    func pushFrame() {
        
    }
    func tapped() {
        
    }
    var onFilterChainNeedsRebuilding: (() -> ())?
    weak var viewController: UIViewController?
    var canActivate: Bool {
        get {
            return true
        }
    }
}
