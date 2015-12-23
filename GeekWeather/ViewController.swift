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
        
        self.testCmdExec()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testCmdExec() {
        let commandLine1 : CommandLine = try! CommandLineParser.shareParser.parse("ls asd -1 -a")!
        let command = try! CommandLineParser.shareParser.buildCommand(commandLine1)
        ShellCore.defaultShellCore.delegate = self
        let ret = ShellCore.defaultShellCore.execute(command)
        if ret {
            print(":>")
        }
    }
    
    func didReturnResult(result: String!) {
        print(result);
    }
}

