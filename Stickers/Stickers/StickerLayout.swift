//
//  StickerLayout.swift
//  Stickers
//
//  Created by Nate Parrott on 6/16/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit

class StickerLayout: StylePickerItem {
    var hasText: Bool {
        get {
            return false
        }
    }
    func position(container: UIView, image: UIView, text: UIView?) {
        
    }
    var title: String {
        get {
            return ""
        }
    }
    var iconName: String? {
        get {
            return nil
        }
    }
}
