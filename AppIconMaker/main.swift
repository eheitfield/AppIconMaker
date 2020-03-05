//
//  main.swift
//  AppIconMaker
//
//  Created by Erik Heitfield on 2/29/20.
//  Copyright © 2020 Erik Heitfield. All rights reserved.
//
// This file makes use of Apple's swift argument parser framework:
// https://github.com/apple/swift-argument-parser

import Foundation
import AppKit
import ArgumentParser

struct AppIconMaker: ParsableCommand {

    @Argument(help: "PNG image file used for icons (should be square).")
    var inputFile: String

    @Option(name: .shortAndLong,
            default: ".",
            help: "Directory where icon set will be stored.")
    var outputPath: String
    
    mutating func validate() throws {
        
        let fm = FileManager.default
        var isDirectory: ObjCBool = true
        
        if !fm.fileExists(atPath: inputFile, isDirectory: &isDirectory) {
            throw ValidationError("Input file \"\(inputFile)\" not found.")
        } else if isDirectory.boolValue {
            throw ValidationError("\"\(inputFile)\" is a directory, not a file.")
        }
        if !fm.fileExists(atPath: outputPath, isDirectory: &isDirectory) {
            throw ValidationError("\"\(outputPath) is not a valid path.")
        } else if !isDirectory.boolValue {
            throw ValidationError("\"\(outputPath)\" is a file, not a directory.")
        }
        
    }

    func run() throws {

        let fm = FileManager.default

        // Prepare to create appiconset.
        guard let imageData = try? NSData(contentsOfFile: inputFile) as Data else {
            throw RuntimeError("Unable to read image file \"\(inputFile)\".")
        }
        guard let image = NSImage(data: imageData) else {
            throw RuntimeError("Input image file appears to be corrupted.")
        }
        if !fm.changeCurrentDirectoryPath(outputPath) {
            throw RuntimeError("Unable to reach output directory \"\(outputPath)\".")
        }
        if fm.fileExists(atPath: IconLists.AppIcon.dirName) {
            print("\(IconLists.AppIcon.dirName) already exists. Would you like to replace it (Y/N)? ")
            if let answerString = readLine(strippingNewline: true) {
                if answerString.uppercased() != "Y" && answerString.uppercased() != "YES" {
                    print("AppIconMaker cancelled.")
                    return
                }
            }
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
        try IconLists.AppIcon.iconSpecs.forEach { iconSpec in
            let image = iconSpec.makeIconImage(fromImage: image)
            guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
                throw RuntimeError("Error creating icon image files.")
            }
            let newRep = NSBitmapImageRep(cgImage: cgImage)
            newRep.size = image.size
            guard let pngData = newRep.representation(using: .png, properties: [:]) else {
                throw RuntimeError("Error creating icon image files.")
            }
            try pngData.write(to: iconSetURL.appendingPathComponent(iconSpec.filename, isDirectory: false))
        }
        print("AppIconMaker finished.")
    }

}

struct RuntimeError: Error, CustomStringConvertible {
    
    var description: String

    init(_ description: String) {
        self.description = description
    }
    
}

AppIconMaker.main()
