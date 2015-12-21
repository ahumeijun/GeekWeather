//
//  Command.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

public class Command: NSObject {
    internal(set) var workPath : String {
        get {
            return self.workPath
        }
        set(path) {
            self.workPath = path
        }
    }
    
    var arguments = [String]()
    var options = [CommandOption]()
    var validOptions : [String]
    
    init(path : String) {
        validOptions = [String]()
        super.init()
        workPath = path
    }
    
    func appendArgument(argument : String!) -> Bool! {
        arguments.append(argument)
        return true
    }
    
    func appendOption(option : CommandOption!) -> Bool! {
        if self.validOptions.contains(option.option) {
            options.append(option)
            return true
        }
        return false
    }
    
    enum CmdExecError : ErrorType{
        case CmdNotImp
    }
    
    func execute() throws -> String! {
        throw CmdExecError.CmdNotImp
    }
    
}
