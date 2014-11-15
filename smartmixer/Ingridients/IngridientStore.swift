//
//  IngridientStore.swift
//  smartmixer
//
//  Created by 姚俊光 on 14/9/23.
//  Copyright (c) 2014年 smarthito. All rights reserved.
//

import UIKit

class IngridientStore: UIViewController {

    
    @IBOutlet var webPage:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = NSURLRequest(URL: NSURL(string: "http://www.smarthito.com/publicstore"))
        webPage.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }

}
