//
//  ls.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ls: Command {
    
    override init() {
        super.init()
        self.validOptions.appendContentsOf(["1", "a"])
    }
    
    override func execute() throws -> String! {
        var results : [String] = [String]()
        
        for option in self.options {
            if let argument = option.argument {
                self.arguments.append(argument)
            }
        }
        
        if self.arguments.isEmpty {
            self.arguments.append(".");
        }
        
        for path in self.arguments {
            
            self.delegate.pathTree.push()
            defer {
                self.delegate.pathTree.pop()
            }
            
            do {
                try self.delegate.pathTree.moveToPath(path)
            } catch {
                throw error
            }
            
            DDLogDebug("ls path is \(self.delegate.pathTree.workPtr.treepath())")
            
            var paths = self.delegate.pathTree.workPtr.contents()
            
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
