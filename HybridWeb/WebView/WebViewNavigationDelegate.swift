//
//  WebViewNavigationDelegate.swift
//  HybridWeb
//
//  Created by nextez on 2022/04/27.
//

import WebKit

extension MainWebView.Coordinator: WKNavigationDelegate {
    
    // MainWebView.Coordinator 클래스의 webView에 mainWebView 설정
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WKNavigationDelegate: webView() - didFinish")
        self.currentWebView = webView
    }
    
}
