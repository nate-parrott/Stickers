//
//  StickerCaptureViewController.swift
//  Stickers
//
//  Created by Nate Parrott on 6/18/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit
import GPUImage

class StickerCaptureViewController: UIViewController {
    // MARK: Views
    @IBOutlet private var previewView: GPUImageView!
    @IBOutlet private var shapePicker: StylePicker!
    @IBOutlet private var shutterButton: UIButton!
    
    // MARK: Pipeline
    private var pipeline: StickerCapturePipeline? {
        didSet(old) {
            old?.cleanUp()
            old?.source.onFilterChainNeedsRebuilding = nil
            pipeline?.source.onFilterChainNeedsRebuilding = {
                [weak self] in
                self?._rebuildPipeline()
            }
            pipeline?.source.viewController = self
        }
    }
    private func _rebuildPipeline() {
        if let old = pipeline {
            pipeline = StickerCapturePipeline(source: old.source, shape: old.shape, outputView: previewView)
        }
    }
    
    func notEquals(a: Bool, b: Bool) -> Bool {
        return a != b
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.setBackgroundColorRed(1, green: 1, blue: 1, alpha: 1)
        previewView.backgroundColor = UIColor.black()
        
        shapePicker.showLabels = false
        shapePicker.items = StickerShape.AllShapes
        shapePicker.onSelectionChanged = {
            [weak self] in
            if let index = self?.shapePicker?.selection {
                self?.changeShape(shape: self?.shapePicker.items[index] as! StickerShape)
            }
        }
        
        shutterButton.addTarget(self, action: #selector(StickerCaptureViewController._shutterDown), for: .touchDown)
        shutterButton.addTarget(self, action: #selector(StickerCaptureViewController._shutterUp), for: [.touchUpInside, .touchUpOutside])
        
        shapePicker.selection = 0
        shapePicker.onSelectionChanged!()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pipeline = StickerCapturePipeline(source: ImageSource.AllSources.first!, shape: StickerShape.AllShapes[0], outputView: previewView)
        /*pipeline!.output.useNextFrameForImageCapture()
        pipeline!.output.frameProcessingCompletionBlock = {
            (op: GPUImageOutput?, time) in
            let image = self.pipeline!.output.imageFromCurrentFramebuffer()!
            let path = NSTemporaryDirectory() + "image.png"
            try! UIImagePNGRepresentation(image)!.write(to: URL(fileURLWithPath: path))
            print("\(path)")
            self.pipeline!.output.frameProcessingCompletionBlock = nil
        }*/
    }
    
    // MARK: Capture
    @objc private func _shutterDown() {
        
    }
    
    @objc private func _shutterUp() {
        
    }
    
    // MARK: Actions
    @IBAction func dismiss() {
        // TODO
    }
    
    @IBAction func changeSource() {
        var index = ImageSource.AllSources.index(of: pipeline!.source)!
        while true {
            let source = ImageSource.AllSources[(index + 1) % ImageSource.AllSources.count]
            if source.canActivate {
                changeSource(source: source)
                break
            } else {
                index += 1
            }
        }
    }
    
    func changeSource(source: ImageSource) {
        if let old = pipeline {
            pipeline = StickerCapturePipeline(source: source, shape: old.shape, outputView: previewView)
        }
    }
    
    func changeShape(shape: StickerShape) {
        if let old = pipeline {
            pipeline = nil
            pipeline = StickerCapturePipeline(source: old.source, shape: shape, outputView: previewView)
        }
    }
    
    @IBAction func tappedImage() {
        pipeline?.source.tapped()
    }
}
