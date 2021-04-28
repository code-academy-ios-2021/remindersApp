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
        tryAskPermission {
            scheduleNotification(title: title, body: body, after: after)
        }
    }
    
    static func tryScheduleNotification(
        title: String,
        body: String,
        date: Date
    ) {
        tryAskPermission {
            scheduleNotification(title: title, body: body, date: date)
        }
    }
}

extension UserNotificationManager {
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
    
    private static func scheduleNotification(
        title: String,
        body: String,
        date: Date
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    private static func tryAskPermission(_ completion: @escaping () -> ()) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                PermissionsManager.askNotificationPermission { granted in
                    if granted {
                        completion()
                    }
                }
            } else if settings.authorizationStatus == .authorized {
                completion()
            }
        }
    }
}
