//
//  AppFonts.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 30/10/2021.
//

import Foundation
import UIKit

enum TextSize: CGFloat {
    case largeTitle = 34
    case title1 = 28
    case title2 = 22
    case title3 = 20
    case headline = 18
    case subheadline = 17
    case body = 13
    case callout = 15
    case caption1 = 12
    case caption2 = 11
}

private func fontMetrics(for size: TextSize) -> UIFontMetrics {
    switch size {
    case .largeTitle:
        return UIFontMetrics(forTextStyle: .largeTitle)
    case .title1:
        return UIFontMetrics(forTextStyle: .title1)
    case .title2:
        return UIFontMetrics(forTextStyle: .title2)
    case .title3:
        return UIFontMetrics(forTextStyle: .title3)
    case .headline:
        return UIFontMetrics(forTextStyle: .headline)
    case .subheadline:
        return UIFontMetrics(forTextStyle: .subheadline)
    case .body:
        return UIFontMetrics(forTextStyle: .body)
    case .callout:
        return UIFontMetrics(forTextStyle: .callout)
    case .caption1:
        return UIFontMetrics(forTextStyle: .caption1)
    case .caption2:
        return UIFontMetrics(forTextStyle: .caption2)
    }
}

enum FontThonburi {
    case normal, bold
    
    var fontName: String {
        switch self {
        case .bold:
            return "Thonburi-Bold"
        case .normal:
            return "Thonburi-Light"
        }
    }
}

func renderThonburi(with size: TextSize, weight: FontThonburi) -> UIFont {
    guard let fontThonburi = UIFont(name: weight.fontName, size: size.rawValue) else {
        fatalError("Unable to load font \(weight.fontName)")
    }
    return fontMetrics(for: size).scaledFont(for: fontThonburi)
}
