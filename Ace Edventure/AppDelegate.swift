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
     
    let gcmMessageKey = "gcm_Message_ID"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
         UNUserNotificationCenter.current().delegate = self
         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
         UNUserNotificationCenter.current().requestAuthorization(
         options: authOptions,
         completionHandler: {_, _ in }
         )
         
         application.registerForRemoteNotifications()
         
         Messaging.messaging().delegate = self*/
         
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
     
     // MARK: - UNUserNotificationCenterDelegate
     extension AppDelegate: UNUserNotificationCenterDelegate {
     // Receive displayed notifications for iOS 10 devices.
     func userNotificationCenter(_ center: UNUserNotificationCenter,
     willPresent notification: UNNotification,
     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
     let userInfo = notification.request.content.userInfo
     print(userInfo)
     completionHandler([[.alert, .sound]])
     }
     
     func userNotificationCenter(_ center: UNUserNotificationCenter,
     didReceive response: UNNotificationResponse,
     withCompletionHandler completionHandler: @escaping () -> Void) {
     let userInfo = response.notification.request.content.userInfo
     print(userInfo)
     completionHandler()
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
    
}
