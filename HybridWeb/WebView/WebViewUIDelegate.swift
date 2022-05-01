//
//  WebViewUIDelegate.swift
//  HybridWeb
//
//  Created by nextez on 2022/04/27.
//

import WebKit

extension MainWebView.Coordinator: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("runJavaScriptAlertPanelWithMessage: message=[\(message)]")
        
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in completionHandler() })
        showAlert(alert: alert)
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("runJavaScriptConfirmPanelWithMessage: message=[\(message)]")
        
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .destructive) { _ in completionHandler(false) })
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in completionHandler(true) })
        showAlert(alert: alert)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("runJavaScriptTextInputPanelWithPrompt: prompt=[\(prompt)] defaultText=[\(defaultText ?? "")]")
        
        let alert = UIAlertController(title: "알림", message: prompt, preferredStyle: .alert)
        
        var inputTextField: UITextField?
        alert.addTextField() { textField in
            textField.placeholder = defaultText
            inputTextField = textField
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .destructive) { _ in completionHandler(nil) })
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in completionHandler(inputTextField?.text) })
        showAlert(alert: alert)
    }
    
    
    // 알림창 출력
    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }

    // keyWindow 획득
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
                .filter {$0.activationState == .foregroundActive}
                .compactMap {$0 as? UIWindowScene}
                .first?.windows.filter {$0.isKeyWindow}.first
    }

    // 최상위 VC 획득
    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
}
