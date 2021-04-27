//
//  UserNotificationManager.swift
//  remindersApp
//
//  Created by Education on 27/04/2021.
//

import Foundation
import UserNotifications

struct UserNotificationManager {
    static func tryScheduleNotification(
        title: String,
        body: String,
        after: TimeInterval
    ) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                PermissionsManager.askNotificationPermission { granted in
                    if granted {
                        scheduleNotification(title: title, body: body, after: after)
                    }
                }
            } else if settings.authorizationStatus == .authorized {
                scheduleNotification(title: title, body: body, after: after)
            }
        }
    }
    
    private static func scheduleNotification(
        title: String,
        body: String,
        after: TimeInterval
    ) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: after, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        center.add(request)
    }
}
