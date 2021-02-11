//
//  FileManage.swift
//  Memong
//
//  Created by punky on 2020/12/27.
//

import SwiftUI

//MARK: - File Mangement Common functions libraries
struct CustomFileManager {
    static let homeDirURL = URL(fileURLWithPath: NSHomeDirectory());
    static let path = homeDirURL.relativePath
    static let manageFolder =  ".memongAppData"
    static let myFilePath = path + "/" + manageFolder
    static let folderSeperator = "_"
    
    
    // Get all folder list
    static func getFolderList() -> [String]? {
        
        let fm = FileManager.default
        
        do {
            if !fm.fileExists(atPath: myFilePath) {
                
                // 폴더가 없으면 하나 만들기
                let nestedFolderURL = homeDirURL.appendingPathComponent(manageFolder)
                
                try fm.createDirectory(
                    at: nestedFolderURL,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            }
            print("myfilePath \(myFilePath)")
            // 폴더 내 파일 접근
            let items = try fm.contentsOfDirectory(atPath: myFilePath)
            print("path \(items)")
            var array = ["X"]
            array.append(contentsOf: items)
            return array
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // Create new Folder
    static func createFolder(_ name: String) -> Int {
        let fm = FileManager.default
        // UUID().uuidString
        let folderName = name
        
        do {
            let url = URL(fileURLWithPath: myFilePath)
            let nestedFolderURL = url.appendingPathComponent(folderName)
            
            // folder가 이미 존재하는지 체크하기
            if !fm.fileExists(atPath: myFilePath + "/" + folderName) {
                
                try fm.createDirectory(
                    at: nestedFolderURL,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
                
                return 1
            } else {
                // Duplicated file Error
                return 2
            }
            
        } catch {
            print(error)
            return 0
        }
       
        
    }
    
    // Get all file list from a given folder path
    static func getFileList(_ folderName: String) -> [String]? {
        if folderName == "" {
            return nil
        }
        
        let fm = FileManager.default
        let fullFilePath = myFilePath + "/" + folderName
        
        do {
            
            print("fullFilePath \(fullFilePath)")
            let items = try fm.contentsOfDirectory(atPath: fullFilePath)
            print("fullFilePath items \(items)")
            var array = ["X"]
            array.append(contentsOf: items)
            return array
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // Create a new file
    static func createNewFile(of fileName: String, in folderName: String) -> (Int, String) {
        let fm = FileManager.default
        let fullFileName = fileName+".txt"
        
        do {
            let url = URL(fileURLWithPath: myFilePath + "/" + folderName)
            let newFileFullPath = url.appendingPathComponent(fullFileName)
            print("new filePath \(newFileFullPath.absoluteString)")
            // file이 이미 존재하는지 체크하기
            if !fm.fileExists(atPath: myFilePath + "/" + folderName + "/" + fullFileName) {
                
                try "".write(to: newFileFullPath, atomically: true, encoding: .utf8)
                let input = try String(contentsOf: newFileFullPath, encoding: .utf8)
                print("input \(input)")
                
                return (1, fullFileName)
            } else {
                // Duplicated file Error
                return (2, "Duplicated file Error")
            }
            
        } catch {
            print(error.localizedDescription)
            return (0, error.localizedDescription)
        }
    }
    
    // Read a file content
    static func getFileContents(of fullFileName: String, in folderName: String) -> String {
        if fullFileName == "" {
            return ""
        }
        
        do {
            let url = URL(fileURLWithPath: myFilePath + "/" + folderName)
            let fileFullPath = url.appendingPathComponent(fullFileName)
            print("fileFullPath \(fileFullPath.absoluteString)")

            // file이 이미 존재하는지 체크하기
            let content = try String(contentsOf: fileFullPath, encoding: .utf8)
            return content
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    // Save file
    static func saveFile(of fullFileName: String, in folderName: String, contents: String) {
        let fm = FileManager.default
        
        do {
            let url = URL(fileURLWithPath: myFilePath + "/" + folderName)
            let fileFullPath = url.appendingPathComponent(fullFileName)
            print("filePath \(fileFullPath.absoluteString)")
            // file이 이미 존재하는지 체크하기
            if fm.fileExists(atPath: myFilePath + "/" + folderName + "/" + fullFileName) {
                try contents.write(to: fileFullPath, atomically: true, encoding: .utf8)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Remove file
    static func removeFile(of fullFileName: String, in folderName: String) -> Bool {
        let fm = FileManager.default
        let fullPath = myFilePath + "/" + folderName + "/" + fullFileName
        do {
            print("remove filePath \(fullPath)")
            
            // file이 이미 존재하는지 체크하기
            if fm.fileExists(atPath: fullPath) {
                try fm.removeItem(atPath: fullPath)
                return true
            }
            
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    
    // Remove folder
    static func removeFolder(of folderName: String) -> Bool {
        let fm = FileManager.default
        let fullPath = myFilePath + "/" + folderName
        
        do {
            print("remove filePath \(fullPath)")
            
            // 폴더가 이미 존재하는지 체크하기
            if fm.fileExists(atPath: fullPath) {
                try fm.removeItem(atPath: fullPath)
                return true
            }
            
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

//MARK: - File or Folder Error Alert Type Enum
enum ActiveAlert {
    case showingAlertDuplicated, showingAlerteError
}
