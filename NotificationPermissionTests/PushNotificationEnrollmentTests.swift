//
//  PushNotificationEnrollmentTests.swift
//  NotificationPermissionTests
//
//  Created by Nischal Hada on 26/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift
import UserNotifications

@testable import NotificationPermission

class PushNotificationEnrollmentTests: QuickSpec {

    override func spec() {
        var testRequest: PushNotificationEnrollment!
        var testScheduler: TestScheduler!
        var mockNotificationCenter: MockUNUserNotificationCenterProtocol!

        describe("PushNotificationEnrollment") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)

                mockNotificationCenter = MockUNUserNotificationCenterProtocol()

                stub(mockNotificationCenter) { (stub) in
                    when(stub.getNotificationSettings(completionHandler: any())).thenDoNothing()
                    when(stub.requestAuthorization(options: any(), completionHandler: any())).thenDoNothing()
                }

                testRequest = PushNotificationEnrollment(withNotificationCenter: mockNotificationCenter)

            }

            describe("When call EKEventStore for requestAccess") {
                context("when requestAccess request succeed with authorizationStatus true", {
                    var result: MaterializedSequenceResult<Bool>?

                    beforeEach {
                        stub(mockNotificationCenter) { (stub) in
                            when(stub.getNotificationSettings(completionHandler: any())).thenDoNothing()
                            when(stub.requestAuthorization(options: any(), completionHandler: any())).then { (arg0) in
                                let (_, notificationCenterCompletionHandler) = arg0
                                notificationCenterCompletionHandler(true, nil)
                            }
                        }
                        result = testRequest.requestAccess.toBlocking(timeout: 2).materialize()
                    }
                    it("completes successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockNotificationCenter).requestAuthorization(options: any(), completionHandler: any())
                    })
                    it("emits the authorizationStatus true", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, true),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })

                })

                context("when requestAccess request succeed with authorizationStatus false", {
                    var result: MaterializedSequenceResult<Bool>?

                    beforeEach {
                        stub(mockNotificationCenter) { (stub) in
                            when(stub.getNotificationSettings(completionHandler: any())).thenDoNothing()
                            when(stub.requestAuthorization(options: any(), completionHandler: any())).then { (arg0) in
                                let (_, notificationCenterCompletionHandler) = arg0
                                notificationCenterCompletionHandler(false, nil)
                            }
                        }
                        result = testRequest.requestAccess.toBlocking(timeout: 2).materialize()
                    }
                    it("completes successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockNotificationCenter).requestAuthorization(options: any(), completionHandler: any())
                    })
                    it("emits the authorizationStatus false", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when requestAccess failed with error ", {
                    var result: MaterializedSequenceResult<Bool>?
                    let mockCustomerError =  NSError(domain: "MockError", code: 0, userInfo: nil)

                    beforeEach {
                        stub(mockNotificationCenter) { (stub) in
                            when(stub.getNotificationSettings(completionHandler: any())).thenDoNothing()
                            when(stub.requestAuthorization(options: any(), completionHandler: any())).then { (arg0) in
                                let (_, notificationCenterCompletionHandler) = arg0
                                notificationCenterCompletionHandler(false, mockCustomerError)
                            }
                        }

                        result = testRequest.requestAccess.toBlocking(timeout: 2).materialize()
                    }
                    it("it fails with error", closure: {
                        result?.assertSequenceDidFail()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockNotificationCenter).requestAuthorization(options: any(), completionHandler: any())
                    })
                    it("emits the authorizationStatus true", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.error(200, mockCustomerError, Bool.self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            }
        }
    }
}
