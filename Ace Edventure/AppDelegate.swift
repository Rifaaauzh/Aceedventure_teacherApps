//
//  AppDelegate.swift
//  Ace Edventure
//
//  Created by Rifa Fauziah on 31/05/2024.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var notificationHandler: NotificationHandler?
     
    let gcmMessageKey = "gcm_Message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         FirebaseApp.configure()
        
         notificationHandler = NotificationHandler()
        
         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         UNUserNotificationCenter.current().requestAuthorization(
         options: authOptions,
         completionHandler: {_, _ in }
         )
         
         application.registerForRemoteNotifications()
         
         Messaging.messaging().delegate = self
         
         return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         Messaging.messaging().apnsToken = deviceToken
         print("APNs token retrieved: \(deviceToken)")
     }
     
     func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
         print("Failed to register for remote notifications with error: \(error)")
     }
}
     
     // MARK: - MessagingDelegate
     extension AppDelegate: MessagingDelegate {
     func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
     
         print("Firebase registration token: \(String(describing: fcmToken))")
         let dataDict: [String: String] = ["token": fcmToken ?? ""]
         NotificationCenter.default.post(
             name: Notification.Name("FCMToken"),
             object: nil,
             userInfo: dataDict
         )
     }
}
