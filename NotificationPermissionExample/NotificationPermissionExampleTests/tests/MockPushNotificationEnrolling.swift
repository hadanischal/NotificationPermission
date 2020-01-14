// MARK: - Mocks generated from file: ../NotificationPermission/Classes/PushNotificationEnrollment.swift at 2020-01-04 10:44:51 +0000

//
//  PushNotificationEnrollment.swift
//  NotificationPermission
//
//  Created by Nischal Hada on 24/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
//swiftlint:disable all

import Cuckoo
import Foundation
import RxSwift
import UserNotifications
@testable import NotificationPermissionExample
@testable import NotificationPermission

public class MockPushNotificationEnrolling: PushNotificationEnrolling, Cuckoo.ProtocolMock {

    public typealias MocksType = PushNotificationEnrolling

    public typealias Stubbing = __StubbingProxy_PushNotificationEnrolling
    public typealias Verification = __VerificationProxy_PushNotificationEnrolling

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: PushNotificationEnrolling?

    public func enableDefaultImplementation(_ stub: PushNotificationEnrolling) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public var requestAccess: Single<Bool> {
        get {
            return cuckoo_manager.getter("requestAccess",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.requestAccess)
        }

    }

    public var authorizationStatus: Single<PushNotificationStatus> {
        get {
            return cuckoo_manager.getter("authorizationStatus",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.authorizationStatus)
        }

    }

    public func setupPushNotifications() -> Single<PushNotificationStatus> {

    return cuckoo_manager.call("setupPushNotifications() -> Single<PushNotificationStatus>",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.setupPushNotifications())
    }

	public struct __StubbingProxy_PushNotificationEnrolling: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager

	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }

	    var requestAccess: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPushNotificationEnrolling, Single<Bool>> {
	        return .init(manager: cuckoo_manager, name: "requestAccess")
	    }

	    var authorizationStatus: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPushNotificationEnrolling, Single<PushNotificationStatus>> {
	        return .init(manager: cuckoo_manager, name: "authorizationStatus")
	    }

	    func setupPushNotifications() -> Cuckoo.ProtocolStubFunction<(), Single<PushNotificationStatus>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockPushNotificationEnrolling.self,
                                                         method: "setupPushNotifications() -> Single<PushNotificationStatus>",
                                                         parameterMatchers: matchers))
	    }

	}

	public struct __VerificationProxy_PushNotificationEnrolling: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation

	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }

	    var requestAccess: Cuckoo.VerifyReadOnlyProperty<Single<Bool>> {
	        return .init(manager: cuckoo_manager, name: "requestAccess", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }

	    var authorizationStatus: Cuckoo.VerifyReadOnlyProperty<Single<PushNotificationStatus>> {
	        return .init(manager: cuckoo_manager, name: "authorizationStatus", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }

	    @discardableResult
	    func setupPushNotifications() -> Cuckoo.__DoNotUse<(), Single<PushNotificationStatus>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setupPushNotifications() -> Single<PushNotificationStatus>",
                                         callMatcher: callMatcher, parameterMatchers: matchers,
                                         sourceLocation: sourceLocation)
	    }

	}
}

public class PushNotificationEnrollingStub: PushNotificationEnrolling {

    public var requestAccess: Single<Bool> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Single<Bool>).self)
        }
    }

    public var authorizationStatus: Single<PushNotificationStatus> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Single<PushNotificationStatus>).self)
        }
    }

    public func setupPushNotifications() -> Single<PushNotificationStatus> {
        return DefaultValueRegistry.defaultValue(for: (Single<PushNotificationStatus>).self)
    }
}
