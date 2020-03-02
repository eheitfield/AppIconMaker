//
//  main.swift
//  AppIconMaker
//
//  Created by Erik Heitfield on 2/29/20.
//  Copyright © 2020 Erik Heitfield. All rights reserved.
//

import Foundation
import ArgumentParser
import AppKit

struct AppIconMaker: ParsableCommand {
        
    @Option(name: .shortAndLong,
            help: "Input image file (should be a square .png file).")
    var inputFile: String
    
    @Option(name: .shortAndLong,
            default: ".",
            help: "Directory where icon set will be stored.")
    var outputPath: String
    
    func run() throws {
        
        let fm = FileManager.default
        
        // Validate input parametes and prepare to create appiconset.
        guard let imageData = try? NSData(contentsOfFile: inputFile) as Data else {
            throw RuntimeError("Unable to read image file \"\(inputFile)\".")
        }
        guard let image = NSImage(data: imageData) else {
            throw RuntimeError("Input image file appears to be currupted.")
        }
        if !fm.changeCurrentDirectoryPath(outputPath) {
            throw RuntimeError("Unable to reach output directory \"\(outputPath)\".")
        }
        if fm.fileExists(atPath: outputPath) {
            throw RuntimeError("\(IconLists.AppIcon.dirName) already exists at \"\(outputPath)\".")
        }
        
        // Create appiconset with metadata
        try fm.createDirectory(atPath: IconLists.AppIcon.dirName, withIntermediateDirectories: true, attributes: nil)
        let iconSetURL = URL(fileURLWithPath: fm.currentDirectoryPath, isDirectory: true)
            .appendingPathComponent(IconLists.AppIcon.dirName, isDirectory: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(Contents(images: IconLists.AppIcon.iconSpecs))
        try jsonData.write(to: iconSetURL.appendingPathComponent("Contents.json", isDirectory: false))

        // Add resized icon image files.
        try IconLists.AppIcon.iconSpecs.forEach { (iconSpec) in
            let image = iconSpec.makeIconImage(fromImage: image)
            guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
                throw RuntimeError("Error creating icon files.")
            }
            let newRep = NSBitmapImageRep(cgImage: cgImage)
            newRep.size = image.size
            guard let pngData = newRep.representation(using: .png, properties: [:]) else {
                throw RuntimeError("Error creating icon files.")
            }
            try pngData.write(to: iconSetURL.appendingPathComponent(iconSpec.filename, isDirectory: false))
        }
    }
    
}

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}

AppIconMaker.main()
