//
//  PushNotificationsViewModel.swift
//  NotificationPermissionExample
//
//  Created by Nischal Hada on 4/1/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift
import NotificationPermission

enum PushNotificationsRoute {
    case dismissAlert // notDetermined then Denied
    case presentDashboard // notDetermined then authorized || authorized
    case presentDeviceSettingsAlert // denied earlier
}

protocol PushNotificationsDataSource: class {
    var deviceSettingsTitle: String { get }
    var deviceSettingsBody: String { get }
    func setupPushNotifications() -> Observable<PushNotificationsRoute>
}

final class PushNotificationsViewModel: PushNotificationsDataSource {

    var deviceSettingsTitle: String {
        return "Turn on notifications"
    }
    var deviceSettingsBody: String {
        return "Keep a good thing going. \nTurn your notifications on and we’ll remind you when it’s time to make a payment."
    }

    private var notificationEnrollment: PushNotificationEnrolling

    init(notificationEnrollment: PushNotificationEnrolling = PushNotificationEnrollment()) {
        self.notificationEnrollment = notificationEnrollment
    }

    func setupPushNotifications() -> Observable<PushNotificationsRoute> {
        return self.notificationEnrollment
            .authorizationStatus
            .asObservable()
            .flatMap({ status -> Observable<PushNotificationsRoute> in
                switch status {
                case .notDetermined, .provisional:
                    return self.requestAccess()
                case .denied:
                    return Observable.just(.presentDeviceSettingsAlert)
                case .authorized:
                    return Observable.just(.presentDashboard)
                }
            })
    }

    private func requestAccess() -> Observable<PushNotificationsRoute> {
        return self.notificationEnrollment
            .requestAccess
            .catchErrorJustReturn(false)
            .asObservable()
            .flatMap { status -> Observable<PushNotificationsRoute> in
                guard status else { return Observable.just(.dismissAlert) }
                return Observable.just(.presentDashboard)
        }
    }
}
