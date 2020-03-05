//
//  Contents.swift
//  AppIconMaker
//
//  Created by Erik Heitfield on 3/2/20.
//  Copyright © 2020 Erik Heitfield. All rights reserved.
//

import Foundation

/// Base structure used for generating iconset JSON metadata.
struct Contents: Codable {

    struct Metadata: Codable {
        let version = 1
        let author = "AppIconMaker"
    }

    let images: [IconSpec]
    let info = Metadata()

}
