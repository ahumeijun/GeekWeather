//
//  cd.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class cd: Command {
    
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
        
        do {
            try self.delegate.pathTree.moveToPath(path)
        } catch {
            throw error
        }
        
        print("current path:\(self.delegate.pathTree.workPtr.treepath())")
        
        return ""
    }
}
