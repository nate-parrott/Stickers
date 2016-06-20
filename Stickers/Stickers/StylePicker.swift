//
//  StylePicker.swift
//  Stickers
//
//  Created by Nate Parrott on 6/16/16.
//  Copyright © 2016 Nate Parrott. All rights reserved.
//

import UIKit

class StylePicker: UIView {
    var items = [StylePickerItem]() {
        didSet {
            buttons = items.map() { (item) in
                let b = UIButton()
                if let icon = item.iconName {
                    b.setImage(UIImage(named: icon)!, for: [])
                }
                b.addTarget(self, action: #selector(StylePicker._tapped), for: .touchUpInside)
                return b
            }
            labels = items.map() { (item) in
                let l = UILabel()
                l.text = item.title
                l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleCaption2)
                return l
            }
            selection = nil
        }
    }
    private var buttons = [UIButton]() {
        didSet (old) {
            for v in old { v.removeFromSuperview() }
            for v in buttons { addSubview(v) }
        }
    }
    private var labels = [UILabel]() {
        didSet(old) {
            for v in old { v.removeFromSuperview() }
            for v in labels { addSubview(v) }
        }
    }
    var selection: Int? {
        didSet {
            var i = 0
            for (btn, label) in zip(buttons, labels) {
                let selected = i == self.selection
                btn.alpha = selected ? 1 : Appearance.deselectedOpacity
                label.alpha = selected ? 1 : Appearance.deselectedOpacity
                label.isHidden = !self.showLabels
                i += 1
            }
        }
    }
    var onSelectionChanged: (() -> ())?
    func _tapped(button: UIButton) {
        selection = buttons.index(of: button)
        if let cb = onSelectionChanged { cb() }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 26
        let itemSize = bounds.size.height
        let width = CGFloat(items.count) * itemSize + (CGFloat(items.count) - 1) * margin
        var x = (bounds.size.width - width)/2
        for (btn, label) in zip(buttons, labels) {
            btn.frame = CGRect(x: x, y: 0, width: itemSize, height: itemSize)
            label.sizeToFit()
            label.center = CGPoint(x: btn.center.x, y: itemSize + 10 + label.bounds.size.height/2)
            x += itemSize + margin
        }
    }
    var showLabels = true {
        didSet {
            for l in labels { l.isHidden = !self.showLabels }
        }
    }
}

@objc protocol StylePickerItem {
    var title: String { get }
    var iconName: String? { get }
}

