//
//  CommandLine.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/15.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

public class CommandLine: NSObject {
    
    public var command : String!
    private var arguments : [String]!
    private var options : [CommandOption]!
    
    override init() {
        command = ""
        arguments = [String]()
        options = [CommandOption]()
    }
    
    override public var description: String {
        return "command:\(command)\narguments:\(arguments)\noptions:\(options)"
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let other = object as? CommandLine {
            
            let isCommandEqual = self.command == other.command
            let isArgumentsElementsEqual = self.arguments!.elementsEqual(other.arguments!)
            var isOptionsElementsEqual = self.options.count == other.options.count
            if isOptionsElementsEqual {
                for optionA in self.options {
                    var exist = false
                    for optionB in other.options {
                        if optionA.isEqual(optionB) {
                            exist = true
                            break
                        }
                    }
                    if !exist {
                        isOptionsElementsEqual = false
                        break
                    }
                }
            }
            return isCommandEqual && isArgumentsElementsEqual && isOptionsElementsEqual
            
        } else {
            return false
        }
    }
    
    public func appendOption(commandOption : CommandOption!) -> Bool {
        var exist = false
        for optionItem in self.options {
            if optionItem.option == commandOption.option {
                optionItem.argument = commandOption.argument
                exist = true
                break;
            }
        }
        if !exist {
            let option = CommandOption()
            option.option = commandOption.option
            option.argument = commandOption.argument;
            self.options.append(option)
            return true
        } else {
            return false
        }
    }
    
    public func appendArgument(argument : String!) -> Bool {
        self.arguments.append(argument)
        return true
    }
}