//
//  PushNotificationsViewController.swift
//  NotificationPermissionExample
//
//  Created by Nischal Hada on 4/1/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PushNotificationsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var enableNotificationButton: UIButton!

    private var viewModel: PushNotificationsDataSource!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PushNotificationsViewModel()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Enable PushNotifications"
        enableNotificationButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .flatMap { _ -> Observable<PushNotificationsRoute> in
                return self.viewModel.setupPushNotifications()
        }
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] route in
            self?.handelNavigation(withRoute: route)
        }).disposed(by: disposeBag)
    }

    private func handelNavigation(withRoute route: PushNotificationsRoute) {
        switch route {
        case .dismissAlert:
            break
        case .presentDashboard:
            dismissScreen()

        case .presentDeviceSettingsAlert:
            setupNotificationsRejected()
        }
    }

    // MARK: - Push Notification enabled
    func dismissScreen() {
        self.showAlertView(withTitle: "Notification Authorized", andMessage: "Notification is previously Authorized.")
    }
    // MARK: - Go To Device Settings
    private func goToSettings() {
        UIApplication.openAppSettings()
    }

    private func setupNotificationsRejected() {
        let alert = UIAlertController(title: viewModel.deviceSettingsTitle,
                                      message: viewModel.deviceSettingsBody,
                                      preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { [weak self] (_: UIAlertAction) in
            self?.goToSettings()
        }

        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        self.present(alert, animated: true, completion: nil)
    }

}

fileprivate extension UIApplication {

    @discardableResult
    static func openAppSettings() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }
        UIApplication.shared.open(settingsURL)
        return true
    }
}

fileprivate extension UIViewController {
    func showAlertView(withTitle title: String?, andMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
