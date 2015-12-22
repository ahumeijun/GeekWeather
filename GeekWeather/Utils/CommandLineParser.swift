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
    
    enum ParseCmdError : ErrorType {
        case ErrorOption(option : String)
        case InvalidString(str : String)
    }
    
    public func parse(command: String) throws -> CommandLine? {
        let arr : [String] = command.componentsSeparatedByString(" ")
        let commandLine = CommandLine()
        commandLine.command = arr.first;
        
        if (arr.count >= 2) {
            var tempOption : CommandOption?
            for index in 1...arr.count - 1 {
                let str : String = arr[index]
                if (str.isEmpty) {
                    continue
                } else if (str.hasPrefix("-")) {
                    let pureValue = str.stringByReplacingOccurrencesOfString("-", withString: "")
                    if (pureValue.isEmpty) {
                        throw ParseCmdError.ErrorOption(option: str)
                    } else if (pureValue.characters.count == 1) {
                        let commandOption = CommandOption()
                        commandOption.option = pureValue
                        commandLine.appendOption(commandOption)
                        tempOption = commandOption
                    } else {
                        for char in pureValue.characters {
                            let commandOption = CommandOption()
                            commandOption.option = String(char)
                            commandLine.appendOption(commandOption)
                        }
                    }
                } else {
                    //TODO: is params valid?
                    if ((tempOption) != nil) {
                        tempOption!.argument = str
                        commandLine.appendOption(tempOption)
                        tempOption = nil
                    } else {
                        commandLine.appendArgument(str)
                    }
                }
            }
        }
        return commandLine;
    }
    
    enum BuildCmdError : ErrorType {
        case CmdNotFound(cmd : String)
        case InvalidOption(option : String)
        case InvalidArgument(argument : String)
    }
    
    public func buildCommand(commandLine : CommandLine) throws -> Command! {
        let cmdType : String = commandLine.command
        var command : Command?
        switch cmdType {
        case "cat":
            command = cat(path: ShellCore.defaultShellCore.homepath)
        case "ls":
            command = ls(path: ShellCore.defaultShellCore.homepath)
        case "cd":
            command = cd(path: ShellCore.defaultShellCore.homepath)
        default:
            break
        }
        
        guard let _ = command else {
            throw BuildCmdError.CmdNotFound(cmd: cmdType)
        }
        
        for argument in commandLine.getArguments() {
            guard let _ = command!.appendArgument(argument) else {
                throw BuildCmdError.InvalidArgument(argument: argument)
            }
        }
        
        for option in commandLine.getOptions() {
            guard let _ = command!.appendOption(option) else {
                throw BuildCmdError.InvalidOption(option: option.option)
            }
        }
        
        return command
    }
}
