//
//  PushNotificationEnrollment.swift
//  NotificationPermission
//
//  Created by Nischal Hada on 24/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import UserNotifications
import RxSwift

public protocol PushNotificationEnrolling: class {
    var requestAccess: Single<Bool> { get }
    var authorizationStatus: Single<PushNotificationStatus> { get }
    func setupPushNotifications() -> Single<PushNotificationStatus>
}

public final class PushNotificationEnrollment: PushNotificationEnrolling {

    private var notificationCenter: UNUserNotificationCenterProtocol

    public init(withNotificationCenter notificationCenter: UNUserNotificationCenterProtocol = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }

    // MARK: - Setup PushNotifications Rx
    public func setupPushNotifications() -> Single<PushNotificationStatus> {
        return self.authorizationStatus
            .flatMap { status -> Single<PushNotificationStatus> in
                if [.denied, .provisional].contains(status) {
                    return self.requestAccess.flatMap { status -> Single<PushNotificationStatus> in
                        guard status else { return Single.just(.denied)}
                        return Single.just(.authorized)
                    }
                }
                return Single.just(status)
        }
    }

    // MARK: - The application's user notification settings
    public var authorizationStatus: Single<PushNotificationStatus> {
        return Single<PushNotificationStatus>.create { single in
            self.notificationCenter
                .getNotificationSettings(completionHandler: { (settings) in
                    let authorizationStatus = settings.authorizationStatus
                    switch authorizationStatus {
                    case .authorized:
                        print ("Push notifications already authorised")
                        single(.success(.authorized))
                    case .denied:
                        print ("Push notifications denied - earlier")
                        single(.success(.denied))
                    case .notDetermined:
                        print ("Push notifications not Determined")
                        single(.success(.notDetermined))
                    case .provisional:
                        print ("Push notifications provisional")
                        single(.success(.provisional))
                    @unknown default:
                        assertionFailure("UNUserNotificationCenter.current().getNotificationSettings.authorizationStatus is not available on this version of OS.")
                    }
                })
            return Disposables.create()
        }
    }

    // MARK: - Request UNUserNotificationCenter
    public var requestAccess: Single<Bool> {
        return Single<Bool>.create { single in
            self.notificationCenter
                .requestAuthorization(options: [.alert, .badge, .sound]) { (isGranted, error) in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    single(.success(isGranted))
            }
            return Disposables.create()
        }
    }
}
