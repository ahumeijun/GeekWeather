//
//  ViewController.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/15.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ShellCoreDelegate {

    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hack Weather"
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        textView = UITextView(frame: self.view.bounds)
        textView.backgroundColor = UIColor.blackColor()
        textView.textColor = UIColor.greenColor()
        textView.font = UIFont.systemFontOfSize(14.0)
        self.view .addSubview(textView)
        
//        self.testPathTree()
        self.testCmdExec()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testPathTree() {
        print(PathTree(user: "geek"))
    }

    func testCmdExec() {
        let commandLine0 : CommandLine = try! CommandLineParser.shareParser.parse("cd aaa")!
        let command0 = try! CommandLineParser.shareParser.buildCommand(commandLine0)
        ShellCore.defaultShellCore.delegate = self
        let ret0 = ShellCore.defaultShellCore.execute(command0)
        if ret0 {
            print(":>")
        }
        
        let commandLine1 : CommandLine = try! CommandLineParser.shareParser.parse("ls -1 -a")!
        let command1 = try! CommandLineParser.shareParser.buildCommand(commandLine1)
        ShellCore.defaultShellCore.delegate = self
        let ret1 = ShellCore.defaultShellCore.execute(command1)
        if ret1 {
            print(":>")
        }
    }
    
    func didReturnResult(result: String!) {
        print(result);
    }
}

