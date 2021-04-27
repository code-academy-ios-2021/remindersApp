//
//  PermissionsManager.swift
//  remindersApp
//
//  Created by Education on 27/04/2021.
//

import Foundation
import UserNotifications

typealias PermissionGranted = Bool

class PermissionsManager {
    static func askNotificationPermission(_ completion: @escaping (PermissionGranted) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            completion(granted)
        }
    }
}
