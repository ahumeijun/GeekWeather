//
//  Command.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

protocol CommandDelegate {
    var pathTree : PathTree {get}
}

public class Command: NSObject {
    
    var delegate : CommandDelegate!
    
    var arguments = [String]()
    var options = [CommandOption]()
    var validOptions : [String]
    
    override init() {
        validOptions = [String]()
        super.init()
    }
    
    public func appendArgument(argument : String!) -> Bool! {
        arguments.append(argument)
        return true
    }
    
    public func appendOption(option : CommandOption!) -> Bool! {
        if self.validOptions.contains(option.option) {
            options.append(option)
            return true
        }
        return false
    }
    
    public enum CmdExecError : ErrorType{
        case CmdNotImp
        case InvalidArgument(arg : String)
        case InvalidOption(opt : String)
        case PathExist(path : String)
        case InvalidFileOrDir(name : String)
    }
    
    public func execute() throws -> String! {
        throw CmdExecError.CmdNotImp
    }
    
}
