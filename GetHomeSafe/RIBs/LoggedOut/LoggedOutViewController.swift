//
//  LoggedOutViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit
import SnapKit
import RxCocoa

protocol LoggedOutPresentableListener: AnyObject {
    func login(withLoginModel loginModel: LoginModel)
    func loginStub(userID: String?, userPW: String?) // << replace this with func login(loginModel)
    func goSignUp()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }

    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let playerFields = buildLoginFields()
        self.loginButton = buildLoginButton(idField: playerFields.idField, pwField: playerFields.pwField)
        buildETCField(idField: playerFields.idField, pwField: playerFields.pwField)
    }

    private var idField: UITextField?
    private var pwField: UITextField?
    private var loginButton: UIButton?

    private func buildLoginFields() -> (idField: UITextField, pwField: UITextField) {
        let emptySpace = UIView()
        view.addSubview(emptySpace)
        emptySpace.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view)
            maker.height.equalTo(150 * view.frame.width / 320)
        }

        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.text = "로그인"
        titleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 20.0)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(emptySpace.snp.bottom)
            maker.leading.trailing.equalTo(self.view).inset(40)
        }

        let idField = customTextField()
        self.idField = idField
        view.addSubview(idField)
        idField.placeholder = "아이디"
        idField.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(18)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(38 * view.frame.width / 320)
        }
        idField.returnKeyType = .next

        let pwField = customTextField()
        self.pwField = pwField
        view.addSubview(pwField)
        pwField.placeholder = "비밀번호"
        pwField.snp.makeConstraints { (maker) in
            maker.top.equalTo(idField.snp.bottom).offset(15)
            maker.left.right.height.equalTo(idField)
        }
        pwField.returnKeyType = .done

        idField.delegate = self
        pwField.delegate = self

        return (idField, pwField)
    }

    private func buildLoginButton(idField: UITextField, pwField: UITextField) -> (UIButton) {
        let loginButton = UIButton()
        self.loginButton = loginButton
        loginButton.layer.cornerRadius = 3
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(pwField.snp.bottom).offset(20)
            maker.left.right.height.equalTo(idField)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.init(red: (123)/255, green: (162)/255, blue: (239)/255, alpha: 1.0)
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.loginStub(userID: idField.text!, userPW: pwField.text!)
            }).disposed(by: disposeBag)

        return loginButton
    }

    private func buildETCField(idField: UITextField, pwField: UITextField) {
        let goSignUpButton = UIButton()
        view.addSubview(goSignUpButton)
        goSignUpButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.loginButton!.snp.bottom).offset(20)
            maker.leading.equalTo(self.view).inset(40)
            maker.height.equalTo(20)
        }
        goSignUpButton.setTitle("회원가입", for: .normal)
        goSignUpButton.setTitleColor(UIColor.black, for: .normal)
        goSignUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        goSignUpButton.setTitleColor(UIColor.gray, for: .normal)
        goSignUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.goSignUp()
            }).disposed(by: disposeBag)

        let skipButton = UIButton()
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.loginButton!.snp.bottom).offset(20)
            maker.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(20)
        }
        skipButton.setTitle("비회원으로", for: .normal)
        skipButton.setTitleColor(UIColor.black, for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        skipButton.setTitleColor(UIColor.gray, for: .normal)
        skipButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.loginStub(userID: idField.text!, userPW: pwField.text!)
            }).disposed(by: disposeBag)
    }

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
    private let disposeBag = DisposeBag()

    private func customTextField() -> TextFieldWithPadding {
        let myTextField = TextFieldWithPadding()
        myTextField.layer.cornerRadius = 4
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.borderColor = UIColor.gray.cgColor
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
                                        // .foregroundColor : UIColor.lightGray])
        myTextField.textColor = UIColor.gray

        return myTextField
    }

    @objc private func didTapLoginButton() {
        print("didTapLoginButton")
    }
}

extension LoggedOutViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idField {
            pwField?.becomeFirstResponder()
        } else {
            pwField?.resignFirstResponder()
        }
        return true
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 12,
        bottom: 10,
        right: 12
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
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
