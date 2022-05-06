//
//  MainWebView.swift
//  HybridWeb
//
//  Created by qwsyv on 2022/04/26.
//

import SwiftUI
import WebKit
import Combine

struct MainWebView: UIViewRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var webViewModel: WebViewModel
    
//    let wkProcessPool = WKProcessPool() //쿠키 공유? (섬프로)
    
    let urlString: String
    
    func makeCoordinator() -> MainWebView.Coordinator {
        print("makeCoordinator")
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        print("makeUIView")
        
//        NotificationCenter.default.addObserver(self, selector: Selector, name: Notification.Name("FCMToken"), object: <#T##Any?#>)
        
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        
        print("url: \(url)")
        
        // 웹뷰 생성
        let newWebView = WKWebView(frame: .zero, configuration: creatWebViewConfiguration(context))
        newWebView.allowsBackForwardNavigationGestures = true // 가로 스와이프 뒤로가기 설정
        
        // WKWebview 의 델리겟 연결을 위한 코디네이터 설정
        newWebView.uiDelegate = context.coordinator
        newWebView.navigationDelegate = context.coordinator
        
//        newWebView.load(URLRequest(url: url))
        
        guard let path: String = Bundle.main.path(forResource: "index", ofType: "html") else {
            return newWebView

        }
        let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        newWebView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
        
        return newWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("updateUIView")
        
    }
    
    
    class Coordinator: NSObject {
        var subscriptions = Set<AnyCancellable>()
        
        let parent: MainWebView
        var currentWebView: WKWebView?
        
        init(_ parent: MainWebView) {
            self.parent = parent
        }
    }
}





