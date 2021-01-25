//
//  WebViewController.swift
//  Networking sudying
//
//  Created by DIMa on 25.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    weak var coordinator: CoursesCoordinator?
    
    let webView = WKWebView()
    var name: String?
    var url: String?
    
    override func viewDidLoad() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        loadPage()
    }
    
    private func loadPage() {
        guard let url = url else { return }
        webView.load(URLRequest(url: URL(string: url)!))
    }
}
