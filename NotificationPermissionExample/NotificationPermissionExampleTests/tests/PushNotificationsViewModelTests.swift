//
//  PushNotificationsViewModelTests.swift
//  NotificationPermissionExampleTests
//
//  Created by Nischal Hada on 4/1/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxSwift
import RxBlocking
import Cuckoo

@testable import NotificationPermissionExample

final class PushNotificationsViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: PushNotificationsViewModel!
        var mockPushNotificationEnrolling: MockPushNotificationEnrolling!

        describe("PushNotificationsViewModel") {
            beforeEach {
                mockPushNotificationEnrolling = MockPushNotificationEnrolling()
                stub(mockPushNotificationEnrolling) { (stub) in
                    when(stub.requestAccess).get.thenReturn(Single.just(true))
                    when(stub.authorizationStatus.get).thenReturn(Single.just(.denied))
                }
                testViewModel = PushNotificationsViewModel(notificationEnrollment: mockPushNotificationEnrolling)
            }

            it("sets the deviceSettingsTitle correctly") {
                let correctResult = "Turn on notifications"
                expect(testViewModel.deviceSettingsTitle).to(equal(correctResult))
            }

            it("sets the deviceSettingsBody text correctly") {
                let correctResult = "Keep a good thing going. \nTurn your notifications on and we’ll remind you when it’s time to make a payment."
                expect(testViewModel.deviceSettingsBody).to(equal(correctResult))
            }

            describe("When user setup PushNotifications", {

                context("when authorizationStatus is authorized ", {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.authorized))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.presentDashboard]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                })

                context("when authorizationStatus is denied ", {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.denied))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.presentDeviceSettingsAlert]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                })

            })

            describe("When user setup PushNotifications and authorizationStatus is notDetermined ", {

                beforeEach {
                    stub(mockPushNotificationEnrolling, block: { stub in
                        when(stub.authorizationStatus).get.thenReturn(Single.just(.notDetermined))
                    })
                }

                context("When requestAccess is true") {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.requestAccess).get.thenReturn(Single.just(true))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.presentDashboard]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                    it("it invoked PushNotificationEnrolling for requestAccess", closure: {
                        verify(mockPushNotificationEnrolling).requestAccess.get()
                    })
                }

                context("When requestAccess is false") {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.requestAccess).get.thenReturn(Single.just(false))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.dismissAlert]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                    it("it invoked PushNotificationEnrolling for requestAccess", closure: {
                        verify(mockPushNotificationEnrolling).requestAccess.get()
                    })
                }
            })

            describe("When user setup PushNotifications and authorizationStatus is provisional ", {

                beforeEach {
                    stub(mockPushNotificationEnrolling, block: { stub in
                        when(stub.authorizationStatus).get.thenReturn(Single.just(.provisional))
                    })
                }

                context("When requestAccess is true") {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.requestAccess).get.thenReturn(Single.just(true))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.presentDashboard]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                    it("it invoked PushNotificationEnrolling for requestAccess", closure: {
                        verify(mockPushNotificationEnrolling).requestAccess.get()
                    })
                }

                context("When requestAccess is false") {
                    var result: [PushNotificationsRoute]?

                    beforeEach {
                        stub(mockPushNotificationEnrolling, block: { stub in
                            when(stub.requestAccess).get.thenReturn(Single.just(false))
                        })
                        result = try? testViewModel.setupPushNotifications().toBlocking(timeout: 2).toArray()
                    }
                    it("emits the image to the UI", closure: {
                        let correctResult: [PushNotificationsRoute] = [.dismissAlert]

                        expect(result?.count).to(equal(1))
                        expect(result).to(equal(correctResult))
                    })
                    it("it invoked PushNotificationEnrolling for authorizationStatus", closure: {
                        verify(mockPushNotificationEnrolling).authorizationStatus.get()
                    })
                    it("it invoked PushNotificationEnrolling for requestAccess", closure: {
                        verify(mockPushNotificationEnrolling).requestAccess.get()
                    })
                }
            })
        }
    }
}
