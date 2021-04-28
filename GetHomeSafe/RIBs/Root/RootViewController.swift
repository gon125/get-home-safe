//
//  RootViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/16.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: - RootViewContorollable
    func present(viewController: ViewControllable) {
        let uiViewController = viewController.uiviewController
        uiViewController.isModalInPresentation = true
        uiViewController.modalPresentationStyle = .fullScreen
        present(uiViewController, animated: false)
    }
    
    func dismiss(viewController: ViewControllable) {
        guard presentedViewController === viewController.uiviewController else { return }
        dismiss(animated: false)
    }
}

extension RootViewController: LoggedInViewControllable {
    
}
