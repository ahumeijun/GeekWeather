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
    
    public func parse(command: NSString) -> CommandLine {
        let commandLine = CommandLine()
        return commandLine;
    }
}
