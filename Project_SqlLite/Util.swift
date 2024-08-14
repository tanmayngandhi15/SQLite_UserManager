//
//  Util.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 25/07/24.
//

import Foundation
// New

class Util: NSObject {
    
    class func getPath(_ fileName: String) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        print("DB Path: \(fileURL.path)")
        return fileURL.path
    }
    
    class func copyDatabase(_ fileName: String) {
        let dbPath = getPath(fileName)
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            guard let bundle = Bundle.main.resourceURL else {
                print("Bundle resource URL is nil.")
                return
            }
            
            let file = bundle.appendingPathComponent(fileName)
            
            do {
                try fileManager.copyItem(atPath: file.path, toPath: dbPath)
                print("DB Success")
            } catch {
                print("Error in DB: \(error.localizedDescription)")
            }
        }
    }
}

// New End

/*
class Util: NSObject {
    
    class func getPath(_ fileName: String) -> String {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        print("DB Path: \(fileURL.path)")
        
        return fileURL.path
    }
    
    class func copyDatabase(_ fileName: String) {
        
    let dbPath = getPath("Signup.db")
        
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(fileName)
            var error: NSError?
            
            do {
                
                try fileManager.copyItem(atPath: (file?.path)!, toPath: dbPath)
    
            } catch let error1 as NSError {
                
                error = error1
            }
            
            if error == nil {
                print("Error in DB")
            } else {
                print("DB Success")
            }
        }
    }
}
*/
