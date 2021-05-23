//
//  LoggedOutViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa

protocol LoggedOutPresentableListener: AnyObject {
    func login(withLoginModel loginModel: LoginModel)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        buildButton()
    }
    
    // MARK: - Private
    
    private func buildButton() {
        let button = UIButton()
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(30)
            maker.left.right.height.equalTo(50)
        }
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.rx.tap
            .subscribe(onNext: { [weak self] in self?.listener?.login(withLoginModel: LoginModel())})
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}

#if DEBUG
import SwiftUI

struct LoggedOutVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        LoggedOutViewController()
    }
}

@available(iOS 13.0.0, *)
struct LoggedOut_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutVCRepresentable()
    }
}
#endif
