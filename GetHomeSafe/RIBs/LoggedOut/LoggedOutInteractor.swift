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
    
    func login(withLoginModel: LoginModel) {
        
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
}
