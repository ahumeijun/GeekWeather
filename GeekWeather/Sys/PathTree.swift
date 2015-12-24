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
    private var children : [PathNode]!
    var parent : PathNode?
    
    override init() {
        super.init()
        children = [PathNode]()
    }
    
    func addChild(child : PathNode) -> Bool {
        children.append(child)
        child.parent = self
        return true
    }
    
    func treepath() -> String! {
        var paths = [String]()
        
        var v : PathNode? = self
        
        repeat {
            paths.append(self.name)
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
        let enumerator = fileManager.enumeratorAtPath(syspath)
        guard let _ = enumerator else {
            return
        }
        while let element = enumerator!.nextObject() as? String {
            let node = PathNode()
            node.name = element
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
        root = PathNode()
        root.name = "Users"
        
        let homenode = PathNode()
        homenode.name = user
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
        for child in node.children {
            desc += traverseNode(level+1, node: child)
        }
        return desc
    }
    
    override var description : String {
        return self.traverse()
    }
}
