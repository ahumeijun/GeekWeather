//
//  ls.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class ls: Command {
    
    override init(path: String) {
        super.init(path: path)
        self.validOptions = ["1", "a"]
    }
    
    enum LsCmdExecError : ErrorType{
        case DirNotFound(dir : String)
    }
    
    override internal func execute() throws -> String! {
        var results : [String] = [String]()
        for path in self.arguments {
            let relativePath = self.workPath + "/\(path)"
            var fullpath : String?
            if NSFileManager.defaultManager().fileExistsAtPath(relativePath) {
                fullpath = relativePath
            }
            else {
                let absolutePath = ShellCore.defaultShellCore.homepath + "/\(path)"
                if NSFileManager.defaultManager().fileExistsAtPath(absolutePath) {
                    fullpath = absolutePath
                } else {
                    throw LsCmdExecError.DirNotFound(dir: path)
                }
            }

            guard let _ = fullpath else {
                continue
            }
            
            var paths = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(fullpath!)
                
            var count = 3
            for option in self.options {
                switch option.option {
                case "1":
                    count = 1
                case "a":
                    paths.append(".")
                    paths.append("..")
                default:
                    break
                }
            }
            
            let max = count
            var result = ""
            for name in paths {
                result += name
                count--
                if count == 0 {
                    result += "\n"
                    count = max
                }
            }
            if result.characters.last != "\n" {
                result += "\n"
            }
            results.append(result)
        }
        return results.joinWithSeparator("\n\n")
    }
}
