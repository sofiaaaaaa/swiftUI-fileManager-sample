//
//  functions.swift
//  Memong
//
//  Created by punky on 2020/12/26.
//

import SwiftUI

//MARK: - File Mangement Common functions libraries
struct MyFileManagement {
    //    let homeDirURL = URL(fileURLWithPath: NSHomeDirectory())
    
    static let homeDirURL = URL(fileURLWithPath: NSHomeDirectory());
    
    
    // Get all folder list
    static func getFolderList() -> [String]? {
        
        let fm = FileManager.default
        //        let path = Bundle.main.resourcePath!
        //        let path = homeDirURL.absoluteString
        let path = homeDirURL.relativePath
        let newFolderName =  ".memongAppData"
        let totalPath = path + "/" + newFolderName

        do {
            if !fm.fileExists(atPath: totalPath) {
                
                // 폴더가 없으면 하나 만들기
                let nestedFolderURL = homeDirURL.appendingPathComponent(newFolderName)
                
                try fm.createDirectory(
                    at: nestedFolderURL,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            }
            
            // 폴더 내 파일 접근
            let items = try fm.contentsOfDirectory(atPath: totalPath)
            print("path \(items)")
            
            return items
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func listAllFileNamesExtension(nameDirectory: String, extensionWanted: String) -> (names : [String], paths : [URL]) {
        //        let allJsonNamePath = listAllFileNamesExtension(nameDirectory:"yourDirectoryName", extensionWanted: "json")
        
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let Path = documentURL.appendingPathComponent(nameDirectory).absoluteURL
        
        do {
            try FileManager.default.createDirectory(atPath: Path.relativePath, withIntermediateDirectories: true)
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: Path, includingPropertiesForKeys: nil, options: [])
            
            // if you want to filter the directory contents you can do like this:
            let FilesPath = directoryContents.filter{ $0.pathExtension == extensionWanted }
            let FileNames = FilesPath.map{ $0.deletingPathExtension().lastPathComponent }
            
            return (names : FileNames, paths : FilesPath);
            
        } catch {
            print(error.localizedDescription)
        }
        
        return (names : [], paths : [])
    }
    
    // Get all folder list
    static func getFolderList2() -> [String]? {
        let fm = FileManager.default
        
        do {
            let rootFolderURL = try fm.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let items = try fm.contentsOfDirectory(atPath: rootFolderURL.absoluteString)
            print("read folders path \(rootFolderURL.absoluteString)")
            
            return items
            
        } catch {
            print(error)
            return nil
        }
    }
    
    static func createFolder3() {
        let fm = FileManager.default
        //let path = Bundle.main.resourcePath!
//        let path = homeDirURL.absoluteString
        
        do {
            let rootFolderURL = try fm.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let path =  "/aaa_" + UUID().uuidString
            let nestedFolderURL = rootFolderURL.appendingPathComponent(path)
            
            try fm.createDirectory(
                at: nestedFolderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
            
            
        } catch {
            print(error)
        }
        
    }
    
    static func createFolder2() {
        let fm = FileManager.default
        do {
            let rootFolderURL = try fm.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let path =  "/aaa_" + UUID().uuidString
            let nestedFolderURL = rootFolderURL.appendingPathComponent(path)
            
            try fm.createDirectory(
                at: nestedFolderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
            
            
        } catch {
            print(error)
        }
        
    }
    
    
    // Create new Folder
    static func createFolder() {
        let fm = FileManager.default
        let path = "aaa_" + UUID().uuidString
        
        //        var path = Bundle.main.resourcePath! + "/aaa_" + UUID().uuidString
        
        //        let newUrl = URL(fileURLWithPath: path)
        
        do {
            
            let nestedFolderURL = homeDirURL.appendingPathComponent(path)
            
            //            let temporaryDirectory = try FileManager.default.url(
            //                for: .itemReplacementDirectory,
            //                in: .userDomainMask,
            //                appropriateFor: desktop,
            //                create: true
            //            )
            
            //Users/punky/Library/Containers/com.softSoft.Memong/Data/
            
            
            try fm.createDirectory(
                at: nestedFolderURL,
                withIntermediateDirectories: false,
                attributes: nil
            )
            
            
            
        } catch {
            // Handle the error.
            print(error)
        }
        
        //        do {
        //            let rootFolderURL = try fm.url(
        //                for: .documentDirectory,
        //                in: .userDomainMask,
        //                appropriateFor: nil,
        //                create: false
        //            )
        //
        //            let nestedFolderURL = rootFolderURL.appendingPathComponent("MyAppFiles")
        //
        //            try fm.createDirectory(
        //                at: nestedFolderURL,
        //                withIntermediateDirectories: false,
        //                attributes: nil
        //            )
        //        } catch {
        //            print(error)
        //        }
        
    }
    
    // Create new File
    static func createFile() {
        let str = "test"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let url = paths[0].appendingPathComponent("message.txt")
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
