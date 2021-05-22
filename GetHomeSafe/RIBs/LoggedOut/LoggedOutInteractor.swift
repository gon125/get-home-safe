//
//  LoggedOutInteractor.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    func routeToSignUp()
//    func cleanupViews()
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: AnyObject {
    func didLogin()
    func didLoginStub(userID: String, userPW: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: LoggedOutPresentable, authenticationUseCase: AuthenticationUseCase) {
        self.authenticationUseCase = authenticationUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        authenticationUseCase.isLoggedIn()
            .subscribe(onNext: { if $0 == true { self.listener?.didLogin() }})
            .disposed(by: disposeBag)

        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - Private
    private let authenticationUseCase: AuthenticationUseCase
    private let disposeBag = DisposeBag()

    func login(withLoginModel: LoginModel) {
//        listener?.didLogin(userID: String, userPW: String)
    }

    func loginStub(userID: String?, userPW: String?) {
        let ID = setUserInfo(userID, withDefaultInfo: "user123")
        let PW = setUserInfo(userPW, withDefaultInfo: "password123")

        print(ID)
        print(PW)
        listener?.didLoginStub(userID: ID, userPW: PW)
    }

    func goSignUp() {
        router?.routeToSignUp()
    }

    func signup(phoneNum: String, newID: String, newPW: String) {
        //
    }

    private func setUserInfo(_ info: String?, withDefaultInfo defaultInfo: String) -> String {
        if let info = info {
            return info.isEmpty ? defaultInfo : info
        } else {
            return defaultInfo
        }
    }
}
