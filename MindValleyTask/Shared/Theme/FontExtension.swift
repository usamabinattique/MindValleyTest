//
//  FontExtension.swift
//  MindValleyTask
//
//  Created by usama on 12/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import UIKit

extension UIFont {

    private enum FontSize {
        static let size: CGFloat = 13.0
    }
    
    convenience init(defaultFontStyle: DefaultFontStyle = .regular, textStyle: UIFont.TextStyle = UIFont.TextStyle.headline, size: CGFloat = FontSize.size) {

        if #available(iOS 11.0, *) {
            let customFont = UIFont(name: defaultFontStyle.fontName, size: size)!
            let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont, maximumPointSize: 34.0)

            print(font)
            self.init(descriptor: font.fontDescriptor, size: 0)
        } else {

            var fontDes = UIFontDescriptor(name: defaultFontStyle.fontName, size: size)
            fontDes = fontDes.addingAttributes([UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.AttributeName.textStyle: textStyle]])
            self.init(descriptor: fontDes, size: 0)
        }
    }

    enum DefaultFontStyle: String {
        case regular
        case black
        case light
        case boldItalic
        case thin
        case mediumItalic
        case medium
        case bold
        case blackItalic
        case italic
        case thinItalic

        var fontName: String {
            return "Roboto-\(self.rawValue.capitalized)"
        }
    }

    static func + (left: UIFont, right: CGFloat) -> UIFont {
        return left.withSize(left.pointSize + right)
    }

    static func - (left: UIFont, right: CGFloat) -> UIFont {
        return left.withSize(left.pointSize - right)
    }
}
