//
//  UserNotificationCenterProtocol.swift
//  NotificationPermission
//
//  Created by Nischal Hada on 27/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import UserNotifications

// This protocol allows you to use UNUserNotificationCenter, and replace the implementation of its
// methods in test classes.
public protocol UNUserNotificationCenterProtocol: class {
    func getNotificationSettings(completionHandler: @escaping (UNNotificationSettings) -> Void)
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}

// Extend UNUserNotificationCenter to conform to this protocol in order to Mock.
extension UNUserNotificationCenter: UNUserNotificationCenterProtocol {
}
