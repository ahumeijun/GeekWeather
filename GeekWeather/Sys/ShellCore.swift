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
    
    func execute(string : String!) -> Bool {
        var commandLine : CommandLine?
        do {
            commandLine = try CommandLineParser.shareParser.parse(string)
        } catch {
            self.delegate?.didReturnResult("command parse error.")
            return false
        }
        
        var command : Command?
        do{
            command = try CommandLineParser.shareParser.buildCommand(commandLine!)
        } catch {
            self.delegate?.didReturnResult("command build error.")
            return false
        }
        
        var result : String?
        do {
            result = try self.execute(command!)
        } catch {
            self.delegate?.didReturnResult("command execute error.")
            return false
        }
        
        self.delegate?.didReturnResult(result!)
        return true
    }
    
    /**
     command execute
     the result will popup by ShellCoreDelegate
     
     - parameter command: Command object, cannot be nil
     
     - returns: return true if execute cmd succeeded, otherwise false
     */
    private func execute(command : Command!) throws -> String {
        var result : String?
        do {
            command.delegate = self
            result = try command.execute()
        } catch {
            throw error
        }
        return result!
    }
    
    var pathTree : PathTree {
        return self.tree
    }
    
}
