//
//  touch.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/23.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

/// create new file only
class touch: Command {
    
    override func execute() throws -> String! {
        guard !self.arguments.isEmpty else {
            throw Command.CmdExecError.InvalidArgument(arg: "path not found")
        }
        
        for path in self.arguments {
            self.delegate.pathTree.push()
            defer {
                self.delegate.pathTree.pop()
            }
            
            let newfile  = path.componentsSeparatedByString("/").last!
            guard RegEx.filenameRegEx.isMatching(newfile) else {
                throw CmdExecError.InvalidFileOrDir(name: newfile)
            }

            
            let end = newfile.characters.count
            
            let dir = path.substringToIndex(path.endIndex.advancedBy(-end))
            
            
            do {
                try self.delegate.pathTree.moveToPath(dir)
            } catch {
                throw error
            }
            
            let pathNode = PathNode(isDirectory: false, name: newfile)
            self.delegate.pathTree.workPtr.addChild(pathNode)
            let isCreated = pathNode.creat()
            guard isCreated else {
                DDLogError("create file failed.")
                throw CmdExecError.PathExist(path: pathNode.name)
            }
        }
        return ""
    }
}
