//
//  CommandLineParser.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/15.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

public class CommandLineParser: NSObject {
    
    static let shareParser : CommandLineParser = CommandLineParser()
    
    var commandLine : CommandLine!
    
    public func parse(command: String) -> CommandLine? {
        
        var error : Int = 0
        
        let arr : [String] = command.componentsSeparatedByString(" ")
        
        let commandLine = CommandLine()
        commandLine.command = arr.first;
        
        if (arr.count >= 2) {
            var tempOption : CommandOption?
            
            for index in 1...arr.count - 1 {
                var value : String = arr[index]
                
                if (value.isEmpty) {
                    continue
                } else if (value.hasPrefix("-")) {
                    value = value.stringByReplacingOccurrencesOfString("-", withString: "")
        
                    if (value.isEmpty) {
                        error = 1
                        break;
                    } else if (value.characters.count == 1) {
                        let commandOption = CommandOption()
                        commandOption.option = value
                        commandLine.appendOption(commandOption)
                        tempOption = commandOption
                    } else {
                        for char in value.characters {
                            let commandOption = CommandOption()
                            commandOption.option = String(char)
                            commandLine.appendOption(commandOption)
                        }
                    }
                } else {
                    if ((tempOption) != nil) {
                        tempOption!.argument = value
                        commandLine.appendOption(tempOption)
                        tempOption = nil
                    } else {
                        commandLine.appendArgument(value)
                    }
                }
            }
        }
        
        if error != 0 {
            print("get an error when parse: \(command)");
            return nil
        }
        return commandLine;
    }
}
