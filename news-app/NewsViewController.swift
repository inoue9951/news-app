//
//  ViewController.swift
//  news-app
//
//  Created by 井上裕太郎 on 2017/10/06.
//  Copyright © 2017年 inoue. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class NewsViewController: UIViewController, WKNavigationDelegate {
    
    var url: String!
    @IBOutlet var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        KRProgressHUD.show()
        webview.navigationDelegate = self
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.allowsBackForwardNavigationGestures = true
        let requestUrl = URL(string: self.url)
        let request = URLRequest(url: requestUrl!)
        webview.load(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            KRProgressHUD.dismiss()
        }
    }
    
}
