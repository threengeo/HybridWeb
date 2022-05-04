//
//  HybridWebApp.swift
//  HybridWeb
//
//  Created by qwsyv on 2022/04/26.
//

import SwiftUI
import Firebase

@main
struct HybridWebApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("didFinishLaunchingWithOptions")
        print("푸시알림: \(UIApplication.shared.isRegisteredForRemoteNotifications ? "ON" : "OFF")")
        
        //캐쉬삭제 (섬프로 이유? 일단 보류)
        /*
         URLCache.shared.removeAllCachedResponses()
         URLCache.shared.diskCapacity = 0
         URLCache.shared.memoryCapacity = 0
         */
        
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    
    // fcm 토큰이 등록 되었을 때
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken: APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // 결국 info.plist FirebaseAppDelegateProxyEnabled: NO 인 경우 아래 주석 해지
        // Messaging.messaging().apnsToken = deviceToken
    }
    
}


// Messaging.messaging().delegate = self
extension AppDelegate : MessagingDelegate {
    
    // fcm 등록 토큰을 받는다.
    // 등록 토큰이 변경되는 경우 (새 기기에서 앱 복원, 사용자가 앱 삭제/재설치, 사용자가 앱 데이터 소거)
    // 앱이 실행 될때마다 그리고 새 토큰이 생성될 때마다 실행
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //print("AppDelegate - 파베 토큰을 받았다.")
        //print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")
        
        // 언제든지 아래를 통해서 등록된 토큰을 가져 올 수 있다.
        /*
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token1 = token {
                print("FCM registration token: \(token1)")
            }
        }
        */
        
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}


extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // 푸시메세지가 앱이 켜져 있을때 나올때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        print("willPresent: userInfo: ", userInfo)
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // 푸시메세지를 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("didReceive: userInfo: ", userInfo)
        completionHandler()
    }
    
}
