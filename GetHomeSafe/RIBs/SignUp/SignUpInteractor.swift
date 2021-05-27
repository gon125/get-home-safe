//
//  SignUpInteractor.swift
//  GetHomeSafe
//
//  Created by khs on 2021/05/20.
//

import RIBs
import RxSwift

protocol SignUpRouting: ViewableRouting {
//    func routeToLoggedOut()
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpListener: class {
    func signup(phoneNum: String, newID: String, newPW: String)
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable, SignUpPresentableListener {

    weak var router: SignUpRouting?
    weak var listener: SignUpListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func signUp(phoneNum: String?, newID: String?, newPW: String?) {
        if phoneNum!.isEmpty || newID!.isEmpty || newPW!.isEmpty {
            print("Fill all text boxes")
        } else {
            print("correct")
            listener?.signup(phoneNum: phoneNum!, newID: newID!, newPW: newPW!)
        }
    }
}
