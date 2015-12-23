//
//  Command.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

public class Command: NSObject {
    
    var workPath : String!
    
    var arguments = [String]()
    var options = [CommandOption]()
    var validOptions : [String]
    
    init(path : String) {
        validOptions = [String]()
        super.init()
        workPath = path
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
        case DirNotFound(path : String)
        case InvalidArgument(arg : String)
        case InvalidOption(opt : String)
    }
    
    public func execute() throws -> String! {
        throw CmdExecError.CmdNotImp
    }
    
}
