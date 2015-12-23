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
    
    override func execute() throws -> String! {
        var results : [String] = [String]()
        
        if self.arguments.isEmpty {
            self.arguments.append("");
        }
        
        let shellCore = ShellCore.defaultShellCore
        
        for path in self.arguments {
            var fullpath : String?
            
            if path == "" {
                fullpath = shellCore.systemPath(shellCore.homepath)
            } else if path.characters.contains(".") {
                do {
                    let relpath = try shellCore.getAbsPath("\(shellCore.workPath)/\(path)")
                    if NSFileManager.defaultManager().fileExistsAtPath(relpath) {
                        fullpath = relpath
                    }
                } catch {
                    throw error
                }
            } else {
                do {
                    let abspath = try shellCore.getAbsPath(path)
                    //list absolute path first
                    let fullAbspath = shellCore.systemPath(abspath)
                    if NSFileManager.defaultManager().fileExistsAtPath(fullAbspath) {
                        fullpath = fullAbspath
                    } else {
                        let relpath = shellCore.workPath + abspath
                        if NSFileManager.defaultManager().fileExistsAtPath(relpath) {
                            fullpath = relpath
                        }
                    }
                } catch {
                    throw error
                }
            }

            guard let _ = fullpath else {
                continue
            }
            
            var paths = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(fullpath!)
                
            var count = 3
            for option in self.options {
                guard self.validOptions.contains(option.option) else {
                    throw CmdExecError.InvalidOption(opt: option.option)
                }
                
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
