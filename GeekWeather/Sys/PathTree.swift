//
//  PathTree.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/23.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class PathNode: NSObject {
    var name : String!
    var isDirectory : Bool = false
    private var children : [PathNode]?
    var parent : PathNode?
    
    init(isDirectory: Bool, name: String) {
        super.init()
        self.isDirectory = isDirectory
        self.name = name
        if isDirectory {
            children = [PathNode]()
        }
    }
    
    func addChild(child : PathNode) -> Bool {
        if self.isDirectory {
            children!.append(child)
            child.parent = self
            return true
        }
        return false
    }
    
    func treepath() -> String! {
        var paths = [String]()
        
        var v : PathNode? = self
        
        repeat {
            paths.append(v!.name)
            v = v!.parent
        } while v != nil
        
        let path = "/\(paths.reverse().joinWithSeparator("/"))"
        return path
    }
    
    func syspath() -> String! {
        var syspath = NSHomeDirectory().stringByAppendingString("/Documents/Shell")
        syspath += self.treepath()
        return syspath
    }
    
    func creat() -> Bool {
        if !NSFileManager.defaultManager().fileExistsAtPath(self.syspath()) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(self.syspath(), withIntermediateDirectories: true, attributes: nil);
            return true
        }
        return false
    }
    
    func loadChildren() {
        let syspath = self.syspath()
        let fileManager = NSFileManager.defaultManager()
        let components = try? fileManager.contentsOfDirectoryAtPath(syspath)
        
        guard let _ = components else {
            return
        }
        
        guard components!.count != 0 else {
            return
        }
        
        for element in components! {
            let path = self.syspath() + "/\(element)"
            var isDir = ObjCBool(false)
            fileManager.fileExistsAtPath(path, isDirectory: &isDir)
            
            let node = PathNode(isDirectory: isDir.boolValue, name: element)
            self.addChild(node)
            node.loadChildren()
        }
    }
    
    override var description : String {
        return name
    }
}

class PathTree: NSObject {
    
    var root : PathNode!
    
    var workPtr : PathNode!
    
    init(user: String!) {
        super.init()
        
        print(NSHomeDirectory())
        
        root = PathNode(isDirectory: true, name: "Users")
        
        let homenode = PathNode(isDirectory: true, name: user)
        root.addChild(homenode)
        homenode.creat()
        homenode.loadChildren()
        
        workPtr = homenode
    }
    
    func traverse() -> String! {
        return self.traverseNode(1, node: self.root) + "------------"
    }
    
    func traverseNode(level : Int, node: PathNode) -> String! {
        var desc = ""
        var i = level
        while i != 0 {
            desc += "-"
            i = i - 1
        }
        desc += " \(node.name)\n"
        
        guard node.isDirectory else {
            return desc
        }
        
        for child in node.children! {
            desc += traverseNode(level+1, node: child)
        }
        return desc
    }
    
    override var description : String {
        return self.traverse()
    }
}
