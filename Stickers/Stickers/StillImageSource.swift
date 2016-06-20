//
//  StillImageSource.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class StillImageSource: ImageSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Picking
    override func tapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        viewController!.present(picker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = image.resized(maxDimension: 1000)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    // MARK: Output
    var image = UIImage(named: "test")! {
        didSet {
            _picture = nil
            if let f = onFilterChainNeedsRebuilding { f() }
        }
    }
    var _picture: GPUImagePicture?
    override var imageOutput: GPUImageOutput! {
        get {
            if _picture == nil {
                _picture = GPUImagePicture(image: image)
            }
            return _picture!
        }
    }
    override var outputSize: CGSize {
        get {
            return image.size
        }
    }
    override func pushFrame() {
        _picture?.processImage()
    }
    override func cleanUp() {
        super.cleanUp()
        _picture = nil
    }
}
