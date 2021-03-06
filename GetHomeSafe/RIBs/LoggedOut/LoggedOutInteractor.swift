//
//  LoggedOutInteractor.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LoggedOutListener: AnyObject {
    func didLogin()
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    
    func login(withLoginModel loginModel: LoginModel) {
        authenticationUseCase.login(loginModel)
            .subscribe(onNext: { [weak self] in if $0 == .success { self?.listener?.didLogin() } })
            .disposed(by: disposeBag)
    }

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
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private
    private let authenticationUseCase: AuthenticationUseCase
    private let disposeBag = DisposeBag()
}
