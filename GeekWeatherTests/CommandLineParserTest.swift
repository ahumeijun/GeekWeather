//
//  CommandLineParserTest.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/16.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import XCTest
@testable import GeekWeather

class CommandLineParserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCommandOptionEqula() {
       let commandOption1 = CommandOption()
        commandOption1.option = "m"
        commandOption1.argument = "hello"
        
        let commandOption2 = CommandOption()
        commandOption2.option = "m"
        commandOption2.argument = "hello"
        
        let commandOption3 = CommandOption()
        commandOption3.option = "m"
        commandOption3.argument = "world"
        
        let commandOption4 = CommandOption()
        commandOption4.option = "n"
        commandOption4.argument = "hello"
        
        let commandOption5 = CommandOption()
        commandOption5.option = "n"
        commandOption5.argument = "world"
        
        let commandOption6 = CommandOption()
        commandOption6.option = "n"
        commandOption6.argument = "world"
        
        let commandOption7 = CommandOption()
        commandOption7.option = "n"
        
        let commandOption8 = CommandOption()
        commandOption8.argument = "world"
        
        let commandOption9 = CommandOption()
        
        XCTAssertTrue(commandOption1.isEqual(commandOption2))
        
        XCTAssertFalse(commandOption1.isEqual(commandOption3))
        XCTAssertFalse(commandOption3.isEqual(commandOption4))
        XCTAssertFalse(commandOption4.isEqual(commandOption5))
        
        XCTAssertTrue(commandOption5.isEqual(commandOption6))
        
        XCTAssertFalse(commandOption6.isEqual(commandOption7))
        XCTAssertFalse(commandOption6.isEqual(commandOption8))
        XCTAssertFalse(commandOption6.isEqual(commandOption9))
        
        XCTAssertFalse(commandOption7.isEqual(commandOption8))
        XCTAssertFalse(commandOption7.isEqual(commandOption9))
        
        XCTAssertFalse(commandOption8.isEqual(commandOption9))
    }
    
    func testCommandLineEqual() {
        //command option
        let commandOption0 = CommandOption()
        commandOption0.option = "m"
        commandOption0.argument = "hello"
        
        let commandOption1 = CommandOption()
        commandOption1.option = "m"
        commandOption1.argument = "hello"
        
        let commandOption2 = CommandOption()
        commandOption2.option = "m"
        commandOption2.argument = "world"
        
        let commandOption3 = CommandOption()
        commandOption3.option = "n"
        commandOption3.argument = "hello"
        
        let commandOption4 = CommandOption()
        commandOption4.option = "n"
        commandOption4.argument = "world"
        
        //command line
        let commandLine0 = CommandLine()
        commandLine0.command = "svn"
        commandLine0.appendArgument("commit")
        commandLine0.appendOption(commandOption0)
        
        let commandLine1 = CommandLine()
        commandLine1.command = "svn"
        commandLine1.appendArgument("commit")
        commandLine1.appendOption(commandOption0)
        
        let commandLine2 = CommandLine()
        commandLine2.command = "svn"
        commandLine2.appendArgument("commit")
        commandLine2.appendOption(commandOption1)
        
        let commandLine3 = CommandLine()
        commandLine3.command = "svn"
        commandLine3.appendArgument("commit")
        commandLine3.appendOption(commandOption2)
        
        let commandLine4 = CommandLine()
        commandLine4.command = "git"
        commandLine4.appendArgument("commit")
        commandLine4.appendOption(commandOption2)
        
        let commandLine5 = CommandLine()
        commandLine5.command = "svn"
        commandLine5.appendArgument("log")
        commandLine5.appendOption(commandOption2)
        
        let commandLine6 = CommandLine()
        commandLine6.command = "git"
        commandLine6.appendArgument("log")
        commandLine6.appendOption(commandOption3)
        
        let commandLine7 = CommandLine()
        commandLine7.command = "svn"
        commandLine7.appendArgument("commit")
        commandLine7.appendOption(commandOption0)
        commandLine7.appendOption(commandOption3);
        
        let commandLine8 = CommandLine()
        commandLine8.command = "svn"
        commandLine8.appendArgument("commit")
        commandLine8.appendOption(commandOption1)
        commandLine8.appendOption(commandOption3)
        
        let commandLine9 = CommandLine()
        commandLine9.command = "svn"
        commandLine9.appendArgument("commit")
        commandLine9.appendOption(commandOption2)
        commandLine9.appendOption(commandOption4)
        
        let commandLine10 = CommandLine()
        commandLine10.command = "svn"
        commandLine10.appendArgument("commit")
        commandLine10.appendOption(commandOption0)
        commandLine10.appendOption(commandOption4)
        
        let commandLine11 = CommandLine()
        commandLine11.command = "svn"
        commandLine11.appendArgument("commit")
        commandLine11.appendOption(commandOption4)
        commandLine11.appendOption(commandOption0)
        
        let commandLine12 = CommandLine()
        commandLine12.command = "svn"
        commandLine12.appendArgument("commit")
        commandLine12.appendOption(commandOption3)
        commandLine12.appendOption(commandOption1)
        
        
        
        XCTAssertTrue(commandLine0.isEqual(commandLine1))
        XCTAssertTrue(commandLine1.isEqual(commandLine2))
        
        XCTAssertFalse(commandLine2.isEqual(commandLine3))
        XCTAssertFalse(commandLine3.isEqual(commandLine4))
        XCTAssertFalse(commandLine4.isEqual(commandLine5))
        XCTAssertFalse(commandLine5.isEqual(commandLine6))
        XCTAssertFalse(commandLine6.isEqual(commandLine2))
        
        XCTAssertFalse(commandLine0.isEqual(commandLine7))
        
        XCTAssertTrue(commandLine7.isEqual(commandLine8))
        XCTAssertFalse(commandLine7.isEqual(commandLine9))
        XCTAssertFalse(commandLine7.isEqual(commandLine10))
        
        XCTAssertFalse(commandLine8.isEqual(commandLine9))
        XCTAssertFalse(commandLine8.isEqual(commandLine10))
        
        XCTAssertFalse(commandLine9.isEqual(commandLine10))
        
        XCTAssertTrue(commandLine10.isEqual(commandLine11))
        XCTAssertTrue(commandLine7.isEqual(commandLine12))
        XCTAssertTrue(commandLine12.isEqual(commandLine8))
    }
    
    func testParse() {
        let commandLine1 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit -m helloworld")!
        let commandLine2 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit -m helloworld")!
        let commandLine3 : CommandLine = try! CommandLineParser.shareParser.parse("svn  commit -m helloworld")!
        let commandLine4 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit  -m helloworld")!
        let commandLine5 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit -m  helloworld")!
        let commandLine6 : CommandLine = try! CommandLineParser.shareParser.parse("svn -m helloworld commit")!
        
        let commandLine7 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit dir -m hello -n world")!
        let commandLine8 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit dir -n world -m hello")!
        let commandLine9 : CommandLine = try! CommandLineParser.shareParser.parse("svn commit -m hello dir -n world")!
        let commandLine0 : CommandLine = try! CommandLineParser.shareParser.parse("svn -m hello commit dir -n world")!
        
        let commandLine10 : CommandLine = try! CommandLineParser.shareParser.parse("svn cat -vct")!
        let commandLine11 : CommandLine = try! CommandLineParser.shareParser.parse("svn -vct cat")!
        let commandLine12 : CommandLine = try! CommandLineParser.shareParser.parse("svn cat -v -c -t")!
        let commandLine13 : CommandLine = try! CommandLineParser.shareParser.parse("svn cat -vc -t")!
        let commandLine14 : CommandLine = try! CommandLineParser.shareParser.parse("svn cat -v -ct")!
        let commandLine15 : CommandLine = try! CommandLineParser.shareParser.parse("svn cat -ctv")!
        
        XCTAssertTrue(commandLine1.isEqual(commandLine2))
        XCTAssertTrue(commandLine2.isEqual(commandLine3))
        XCTAssertTrue(commandLine3.isEqual(commandLine4))
        XCTAssertTrue(commandLine4.isEqual(commandLine5))
        XCTAssertTrue(commandLine5.isEqual(commandLine6))
        
        XCTAssertTrue(commandLine7.isEqual(commandLine8))
        XCTAssertTrue(commandLine7.isEqual(commandLine9))
        XCTAssertTrue(commandLine8.isEqual(commandLine9))
        XCTAssertTrue(commandLine9.isEqual(commandLine0))
        
        XCTAssertTrue(commandLine10.isEqual(commandLine11))
        XCTAssertTrue(commandLine11.isEqual(commandLine12))
        XCTAssertTrue(commandLine12.isEqual(commandLine13))
        XCTAssertTrue(commandLine13.isEqual(commandLine14))
        XCTAssertTrue(commandLine14.isEqual(commandLine15))
    }
    
}
