//
//  WebViewScriptMessageHandler.swift
//  HybridWeb
//
//  Created by nextez on 2022/04/27.
//

import WebKit

extension MainWebView.Coordinator: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("WKScriptMessageHandler - userContentController() | message: \(message.name) \(message.body)")
        
//        let date = Date()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.messageToWebview(msg: "hello, I got your messsage: \(message.body) at \(date)")
//        }
        
        switch message.name {
            
        case "bridge":
            print("bridge...")
            break
            
        case "getGps":
            print("getGps...")
            break
            
        case "getAppVersion":
            print("getAppVersion...")
            break
            
        case "autoLoginYn":
            print("autoLoginYn...")
            break
            
        case "getTokenId":
            print("getTokenId...")
            break
            
        case "clearBadgeCount":
            print("clearBadgeCount...")
            break
            
        default:
            break
        }
    }
    
    func messageToWebview(msg: String) {
        print(msg)
        self.currentWebView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)');")
    }
    
}
