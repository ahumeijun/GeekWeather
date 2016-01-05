//
//  PathTree.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/23.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class PathNode: NSObject {
    var name : String!
    var isDirectory : Bool = false
    private var children : [PathNode]?
    private var parent : PathNode?
    
    var superNode : PathNode? {
        return self.parent
    }
    
    var kids : [PathNode] {
        return self.children!.map({node in node})
    }
    
    init(isDirectory: Bool, name: String) {
        super.init()
        self.isDirectory = isDirectory
        self.name = name
        if isDirectory {
            children = [PathNode]()
        }
    }
    
    func contents() -> [String]! {
        if self.isDirectory {
            return self.children!.map({
                node in
                if node.isDirectory {
                    return "\(node.name)/"
                } else {
                    return node.name
                }
            }).sort()
        } else {
            return [String]()
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
            if self.isDirectory {
                try! NSFileManager.defaultManager().createDirectoryAtPath(self.syspath(), withIntermediateDirectories: true, attributes: nil)
            } else {
                NSFileManager.defaultManager().createFileAtPath(self.syspath(), contents: nil, attributes: nil)
            }
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

/// symbolic link, help to analyze "." and ".."
class LinkNode: PathNode {
    let target : PathNode!
    
    override var superNode : PathNode? {
        return self.target.parent
    }
    
    override var kids : [PathNode] {
        return self.target.children!.map({node in node})
    }
    
    init(target : PathNode, name: String){
        self.target = target
        super.init(isDirectory: false, name: name)
    }
    
    class func addDefaultLink(pathNode : PathNode) {
        let selfPtr = LinkNode(target: pathNode, name: ".")
        var superPtr : LinkNode!
        if let v = pathNode.parent {
            superPtr = LinkNode(target: v, name: "..")
        } else {
            superPtr = LinkNode(target: pathNode, name: "..")
        }
        
        let children = pathNode.kids
        pathNode.addChild(selfPtr)
        pathNode.addChild(superPtr)
        
        for child in children {
            if child.isDirectory {
                LinkNode.addDefaultLink(child)
            }
        }
    }
    
    override func contents() -> [String]! {
        return self.target.contents()
    }
    
    override func addChild(child: PathNode) -> Bool {
        return self.target.addChild(child)
    }
    
    override func treepath() -> String! {
        return self.target.treepath()
    }
    
    override func syspath() -> String! {
        return self.target.syspath()
    }
    
    override func creat() -> Bool {
        return self.target.creat()
    }
    
    override func loadChildren() {
        self.target.loadChildren()
    }
    
    override var description : String {
        return "->\(name)"
    }
}

class PathTree: NSObject {
    
    var rootPtr : PathNode!
    
    var workPtr : PathNode!
    var homePtr : PathNode!
    
    var tempPtr : PathNode?
    
    init(user: String!) {
        super.init()
        
        rootPtr = PathNode(isDirectory: true, name: "Users")
        
        let homenode = PathNode(isDirectory: true, name: user)
        rootPtr.addChild(homenode)
        homenode.creat()
        homenode.loadChildren()
        
        LinkNode.addDefaultLink(rootPtr)
        
        homePtr = homenode
        workPtr = homenode
    }
    
    func push() {
        tempPtr = workPtr
    }
    
    func pop() {
        guard let _ = tempPtr else {
            workPtr = homePtr
            return
        }
        workPtr = tempPtr
    }
    
    enum PathTreeError : ErrorType {
        case PathNotFound(path : String)
        case PathNotDirectory(path : String)
    }
    
    func moveToPath(path : String!) throws -> Bool {
        DDLogDebug("try move to path \(path)")
        push()  //save workPtr
        let rootSearch = path.hasPrefix("/")
        var components = path.componentsSeparatedByString("/")
        var temp : PathNode?
        if rootSearch {
            temp = self.rootPtr
            guard components.first! == temp!.name else {
                throw PathTreeError.PathNotFound(path : path)
            }
            components.removeAtIndex(0)
        } else {
            temp = workPtr
        }
        DDLogDebug("temp node is \(temp!.name)")
        for component in components {
            guard temp!.isDirectory else {
                throw PathTreeError.PathNotDirectory(path: temp!.name)
            }
            
            if component.isEmpty {
                continue
            } else {
                var isExist = false
                for node in temp!.kids {
                    if node.name == component {
                        isExist = true
                        if let v = node as? LinkNode {
                            temp = v.target
                        } else {
                            temp = node
                        }
                    }
                }
                guard isExist else {
                    throw PathTreeError.PathNotFound(path: path)
                }
            }
            
            guard let _ = temp else {
                throw PathTreeError.PathNotFound(path: path)
            }
            DDLogDebug("temp node is \(temp!.name)")
        }
        workPtr = temp
        return true
    }
    
    func traverse() -> String! {
        return self.traverseNode(1, node: self.rootPtr) + "------------"
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
