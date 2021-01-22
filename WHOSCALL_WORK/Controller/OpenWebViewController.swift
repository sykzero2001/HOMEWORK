//
//  OpenWebViewController.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/18.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit
import WebKit

class OpenWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate  {
    var mainWeb = WKWebView()
     var url:String?
     var progressView = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainWeb.navigationDelegate = self
        mainWeb.uiDelegate = self
        self.iniUI()
         let request: NSMutableURLRequest?
//讀取頁面
        if self.url != nil {
            
            request =  NSMutableURLRequest.init(url:URL.init(string: url ?? DEGAULT_URL) ?? (URL.init(string:DEGAULT_URL)!))
           
         
            request?.httpMethod = "GET"
            
            self.mainWeb.load(request! as URLRequest)
            
        }
//讀取條
         self.mainWeb.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        // Do any additional setup after loading the view.
    }
    func iniUI(){
        self.mainWeb.translatesAutoresizingMaskIntoConstraints = false
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mainWeb)
        self.view.addSubview(self.progressView)
// WEBVIEW LAYOUT
        NSLayoutConstraint(item: self.mainWeb, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self.mainWeb, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self.mainWeb, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self.mainWeb, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0).isActive = true
// ProgressView LAYOUT
        
        NSLayoutConstraint(item: self.progressView, attribute: .top, relatedBy: .equal, toItem: mainWeb, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.progressView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: self.progressView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
             NSLayoutConstraint(item: self.progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 5).isActive = true

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(self.mainWeb.estimatedProgress);
        }
        if self.progressView.progress == 1 {
            self.progressView.isHidden = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
