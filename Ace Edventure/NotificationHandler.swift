//
//  NotificationHandler.swift
//  Ace Edventure
//
//  Created by Rifa Fauziah on 05/06/2024.
//

import UIKit
import UserNotifications
import Firebase

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // This method handles the user's interaction with the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        // extract the body of the notification from the UNNotificationResponse object, else if not successful retreive from UserInfo (is a dictionary containing additional data sent with the notification)
         // but "body = notification.request.content.body as String?" works
        if let body = response.notification.request.content.body as String?{
            print("Notification body (content): \(body)")
            redirectToGoogle(body)
        } else if let body = userInfo["body"] as? String {
            print("Notification body (userInfo): \(body)")
            redirectToGoogle(body)
        }

        completionHandler()
    }

    private func redirectToGoogle(_ body: String) {
        if let url = URL(string: body), UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            print("Notification body is not a valid URL: \(body)")
        }
    }
}


