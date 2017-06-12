//
//  LoadFullPageWebviewVC.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/12/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit
import WebKit

class LoadFullPageWebviewVC: UIViewController, WKNavigationDelegate {

    var webview = WKWebView()
    
    var recievedUrl = ""
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
        
        let url = URL(string: recievedUrl)!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recievedUrl

    }

}
