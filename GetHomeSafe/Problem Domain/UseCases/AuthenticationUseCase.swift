//
//  AuthenticationUsecase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import Foundation
import RxSwift

protocol AuthenticationUseCase: UseCase {
    func signup(_ model: SignupModel) -> Observable<SignupState>
    func login(_ model: LoginModel) -> Observable<LoginState>
    func logout()
    func isLoggedIn() -> Observable<Bool>
}

#if DEBUG
typealias DefaultAuthenticationUseCase = StubAuthenticationUseCase

final class StubAuthenticationUseCase: AuthenticationUseCase {
    
    func signup(_ model: SignupModel) -> Observable<SignupState> {
        Observable.just(SignupState.success)
    }
    
    func login(_ model: LoginModel) -> Observable<LoginState> {
        Observable.just(LoginState.success)
    }
    
    func logout() { }
    
    func isLoggedIn() -> Observable<Bool> {
        Observable.just(true)
    }
}
#endif
