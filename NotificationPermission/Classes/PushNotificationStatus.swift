//
//  PushNotificationStatus.swift
//  NotificationPermission
//
//  Created by Nischal Hada on 24/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

public enum PushNotificationStatus {
    // The user has not yet made a choice regarding whether the application may post user notifications.
    case notDetermined
    // The application is not authorized to post user notifications.
    case denied
    // The application is authorized to post user notifications.
    case authorized
    // The application is authorized to post non-interruptive user notifications.
    case provisional
}
