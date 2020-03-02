//
//  IconLists.swift
//  AppIconMaker
//
//  Created by Erik Heitfield on 3/2/20.
//  Copyright © 2020 Erik Heitfield. All rights reserved.
//

import Foundation

struct IconLists {
    struct AppIcon {
        static let iconSpecs = [
            IconSpec(size: .s20, idiom: .iphone, scale: .x2),
            IconSpec(size: .s20, idiom: .iphone, scale: .x3),
            IconSpec(size: .s29, idiom: .iphone, scale: .x2),
            IconSpec(size: .s29, idiom: .iphone, scale: .x3),
            IconSpec(size: .s40, idiom: .iphone, scale: .x2),
            IconSpec(size: .s40, idiom: .iphone, scale: .x3),
            IconSpec(size: .s60, idiom: .iphone, scale: .x2),
            IconSpec(size: .s60, idiom: .iphone, scale: .x3),
            IconSpec(size: .s20, idiom: .ipad, scale: .x1),
            IconSpec(size: .s20, idiom: .ipad, scale: .x2),
            IconSpec(size: .s29, idiom: .ipad, scale: .x1),
            IconSpec(size: .s29, idiom: .ipad, scale: .x2),
            IconSpec(size: .s40, idiom: .ipad, scale: .x1),
            IconSpec(size: .s40, idiom: .ipad, scale: .x2),
            IconSpec(size: .s76, idiom: .ipad, scale: .x1),
            IconSpec(size: .s76, idiom: .ipad, scale: .x2),
            IconSpec(size: .s84, idiom: .ipad, scale: .x2),
            IconSpec(size: .s1024, idiom: .marketing, scale: .x1)
        ]

        static let dirName = "AppIcon.appiconset"

    }
}
