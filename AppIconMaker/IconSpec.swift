//
//  IconSpec.swift
//  AppIconMaker
//
//  Created by Erik Heitfield on 2/29/20.
//  Copyright © 2020 Erik Heitfield. All rights reserved.
//

import AppKit
import Foundation

/// Structure describing icon characteristics.
struct IconSpec: Codable {

    static let baseFileName: String = "icon"

    let size: IconSize
    let idiom: IconIdiom
    let scale: IconScale
    let filename: String

    init(size: IconSize, idiom: IconIdiom, scale: IconScale) {
        self.size = size
        self.idiom = idiom
        self.scale = scale
        self.filename = IconSpec.baseFileName
            + "_"
            + scale.rawValue
            + size.fileStr
            + idiom.rawValue
            + ".png"
    }
    
    /// Return a properly sized icon image for the given specification.
    /// - Parameter image: base icon image
    func makeIconImage(fromImage image: NSImage) -> NSImage {
        let newSize = CGSize(width: size.cgSize.width * scale.cgFloat,
                             height: size.cgSize.height * scale.cgFloat)
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        image.draw(in: newRect,
                   from: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),
                   operation: NSCompositingOperation.sourceOver,
                   fraction: 1.0)
        newImage.unlockFocus()
        return newImage
    }

}

enum IconIdiom: String, Codable {
    case iphone, ipad, mac, universal
    case marketing = "ios-marketing"
}

enum IconScale: String, Codable {
    case x1 = "1x"
    case x2 = "2x"
    case x3 = "3x"

    var cgFloat: CGFloat {
        switch self {
        case .x1: return 1.0
        case .x2: return 2.0
        case .x3: return 3.0
        }
    }
}

enum IconSize: String, Codable {
    case s16 = "16x16"
    case s20 = "20x20"
    case s24 = "24x24"
    case s28 = "27.5x27.5"
    case s29 = "29x29"
    case s32 = "32x32"
    case s40 = "40x40"
    case s44 = "44x44"
    case s60 = "60x60"
    case s76 = "76x76"
    case s84 = "83.5x83.5"
    case s86 = "86x86"
    case s98 = "98x98"
    case s128 = "128x128"
    case s256 = "256x256"
    case s512 = "512x512"
    case s1024 = "1024x1024"

    var cgSize: CGSize {
        switch self {
        case .s16: return CGSize(width: 16, height: 16)
        case .s20: return CGSize(width: 20, height: 20)
        case .s24: return CGSize(width: 24, height: 24)
        case .s28: return CGSize(width: 27.5, height: 27.5)
        case .s29: return CGSize(width: 29, height: 29)
        case .s32: return CGSize(width: 32, height: 32)
        case .s40: return CGSize(width: 40, height: 40)
        case .s44: return CGSize(width: 44, height: 44)
        case .s60: return CGSize(width: 60, height: 60)
        case .s76: return CGSize(width: 76, height: 76)
        case .s84: return CGSize(width: 83.5, height: 83.5)
        case .s86: return CGSize(width: 86, height: 86)
        case .s98: return CGSize(width: 98, height: 98)
        case .s128: return CGSize(width: 128, height: 128)
        case .s256: return CGSize(width: 256, height: 256)
        case .s512: return CGSize(width: 512, height: 512)
        case .s1024: return CGSize(width: 1024, height: 1024)
        }
    }

    // This is an unpleasant workaround for the fact that some of the JSON keys
    // used for the appiconset cannot be used in file names.
    var fileStr: String {
        if self == .s28 {
            return "28x28"
        } else if self == .s84 {
            return "84x84"
        } else {
            return rawValue
        }
    }
}

