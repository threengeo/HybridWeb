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
            self.parent.webViewModel.checkIfLocationServicesIsEnabled()
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
            
        case "openModal":
            print("openModal: \(message.body)")
            if (!self.parent.presentationMode.wrappedValue.isPresented) {
                if let receivedData : [String: String] = message.body as? Dictionary {
                    print("receivedData: \(receivedData["target"] ?? "")")
                    print("receivedData: \(receivedData["name"] ?? "")")
                    self.parent.webViewModel.target.send("https://www.nextez.co.kr")
                }
            }
            break
            
        case "closeModal":
            print("closeModal")
            if (self.parent.presentationMode.wrappedValue.isPresented) {
                print("This is presented.")
                self.parent.presentationMode.wrappedValue.dismiss()
            }
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
