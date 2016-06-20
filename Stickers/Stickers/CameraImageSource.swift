//
//  CameraImageSource.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

class CameraImageSource: ImageSource {
    init(position: AVCaptureDevicePosition) {
        self.position = position
        super.init()
    }
    let position: AVCaptureDevicePosition
    var _camera: GPUImageVideoCamera!
    override var imageOutput: GPUImageOutput! {
        get {
            if _camera == nil {
                _camera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset1280x720, cameraPosition: position)
                _camera!.outputImageOrientation = .portrait
                _camera.horizontallyMirrorFrontFacingCamera = true
                _camera!.startCapture()
            }
            return _camera!
        }
    }
    override var outputSize: CGSize {
        get {
            return CGSize(width: 720, height: 1280)
        }
    }
    override func cleanUp() {
        super.cleanUp()
        _camera?.stopCapture()
        _camera = nil
    }
    override var canActivate: Bool {
        get {
            let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
            return devices.filter({ $0.position == position }).count > 0
        }
    }
}
