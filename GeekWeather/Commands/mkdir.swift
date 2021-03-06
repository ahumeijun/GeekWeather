//
//  mkdir.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/23.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class mkdir: Command {

    override func execute() throws -> String! {
        guard !self.arguments.isEmpty else {
            throw Command.CmdExecError.InvalidArgument(arg: "path not found")
        }
        
        for path in self.arguments {
            self.delegate.pathTree.push()
            defer {
                self.delegate.pathTree.pop()
            }
            
            let newdir  = path.componentsSeparatedByString("/").last!
            guard RegEx.dirnameRegEx.isMatching(newdir) else {
                throw CmdExecError.InvalidFileOrDir(name: newdir)
            }
            
            let end = newdir.characters.count
            
            let dir = path.substringToIndex(path.endIndex.advancedBy(-end))
            
            
            do {
                try self.delegate.pathTree.moveToPath(dir)
            } catch {
                throw error
            }
            
            let pathNode = PathNode(isDirectory: true, name: newdir)
            self.delegate.pathTree.workPtr.addChild(pathNode)
            let isCreated = pathNode.creat()
            guard isCreated else {
                DDLogError("create dir failed.")
                throw CmdExecError.PathExist(path: pathNode.name)
            }
        }
        return ""
    }
}
