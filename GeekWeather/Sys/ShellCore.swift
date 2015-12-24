//
//  ShellCore.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

protocol ShellCoreDelegate {
    func didReturnResult(result : String!)
}

class ShellCore: NSObject, CommandDelegate {
    
    static let defaultShellCore : ShellCore = ShellCore()
    
    override init() {
        super.init()
    }
    
    let tree = PathTree(user: "geek")
    
    var homepath : String! {
        get {
            return tree.homePtr.treepath()
        }
    }
    
    var user: String! {
        get {
            return tree.homePtr.name
        }
    }
    
    var workPath : String! {
        get {
            return tree.workPtr.treepath()
        }
    }
    
    var delegate : ShellCoreDelegate?
    
    /**
     command execute
     the result will popup by ShellCoreDelegate
     
     - parameter command: Command object, cannot be nil
     
     - returns: return true if execute cmd succeeded, otherwise false
     */
    func execute(command : Command!) -> Bool {
        
        var result : String!
        do {
            command.delegate = self
            result = try command.execute()
        } catch PathTree.PathTreeError.PathNotFound(let path) {
            result = "\(path) not found"
        } catch {
            result = "unknown error"
        }
        
        self.delegate?.didReturnResult(result)
        
        return true
    }
    
    var pathTree : PathTree {
        return self.tree
    }
    
}
