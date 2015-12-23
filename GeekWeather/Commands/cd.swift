//
//  cd.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class cd: Command {

    override init(path: String) {
        super.init(path: path)
        self.validOptions = [String]()
    }
    
    override func execute() throws -> String! {
        guard !self.arguments.isEmpty else {
            throw Command.CmdExecError.InvalidArgument(arg: "path not found")
        }
        
        guard self.arguments.count <= 1 else {
            throw Command.CmdExecError.InvalidArgument(arg: "more than one path")
        }
        
        for option in self.options {
            guard self.validOptions.contains(option.option) else {
                throw CmdExecError.InvalidOption(opt: option.option)
            }
        }
        
        let path = self.arguments.first
        
        let shellCore = ShellCore.defaultShellCore
        
        var fullpath : String?
        
        do {
            let abspath = try shellCore.getAbsPath(path)
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
        
        shellCore.workPath = fullpath
        
        return ""
    }
}
