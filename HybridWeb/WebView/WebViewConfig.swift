//
//  WebViewConfig.swift
//  HybridWeb
//
//  Created by nextez on 2022/04/27.
//

import WebKit

extension MainWebView {
    
    func creatWebViewConfiguration(_ context: Context) -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        
        if #available(iOS 14, *) {
            let preferences = WKWebpagePreferences()
            preferences.allowsContentJavaScript = true
            config.defaultWebpagePreferences = preferences
        }
        else {
            config.preferences.javaScriptEnabled = true
            /// user interaction없이 윈도우 창을 열 수 있는지 여부를 나타냄. iOS에서는 기본값이 false이다.
            config.preferences.javaScriptCanOpenWindowsAutomatically = true
        }
        
        let userContentController = WKUserContentController()
        /**
         Javascript - 'bridge' 처럼 이름을 맞춰서 추가 해야 한다.
         webkit.messageHandlers.bridge.postMessage('{"msg": "hello?","id": ' + Date.now() + '}')
         */
        
        //웹뷰간 Cookie공유를 위하여
//        config.processPool = context.coordinator.parent.wkProcessPool
        
        //위치정보 요청
        userContentController.add(context.coordinator, name: "getGps")
        
        //앱버전정보 요청
        userContentController.add(context.coordinator, name: "getAppVersion")
        
        //로그인아이디 요청
        userContentController.add(context.coordinator, name: "autoLoginYn")
        
        //토큰아이디 요청
        userContentController.add(context.coordinator, name: "getTokenId")
        
        //뱃지카운트 초기화
        userContentController.add(context.coordinator, name: "clearBadgeCount")
        
        userContentController.add(context.coordinator, name: "bridge")
        
        userContentController.add(context.coordinator, name: "openModal")
        
        userContentController.add(context.coordinator, name: "closeModal")
        
        config.userContentController = userContentController
        
        return config
    }
    
}
