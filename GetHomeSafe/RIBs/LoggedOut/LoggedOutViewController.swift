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
    
    private let disposeBag = DisposeBag()
    
    private var idField: UITextField?
    private var pwField: UITextField?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        buildSigninView()
    }
    
    private func buildSigninView() {
        let mainView = UIView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (maker) in
            maker.top.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        let userFields = buildLoginFields(mainView)
        let loginButton = buildLoginButton(idField: userFields.idField, pwField: userFields.pwField)
        buildETCField(below: loginButton)
    }
    
    private func buildLoginFields(_ mainView: UIView) -> (idField: UITextField, pwField: UITextField) {
        let viewLabel = UILabel()
        view.addSubview(viewLabel)
        viewLabel.text = "로그인"
        viewLabel.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 20.0)
        viewLabel.textColor = UIColor.darkGray
        viewLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(mainView.snp.top).offset(150 * view.frame.width / 320)
            maker.left.right.equalTo(mainView).inset(40)
        }

        let idField = customTextField()
        self.idField = idField
        view.addSubview(idField)
        idField.placeholder = "아이디"
        idField.snp.makeConstraints { (maker) in
            maker.top.equalTo(viewLabel.snp.bottom).offset(18)
            maker.left.right.equalTo(mainView).inset(40)
            maker.height.equalTo(38 * view.frame.width / 320)
        }
        idField.returnKeyType = .next

        let pwField = customTextField()
        self.pwField = pwField
        view.addSubview(pwField)
        pwField.placeholder = "비밀번호"
        pwField.snp.makeConstraints { (maker) in
            maker.top.equalTo(idField.snp.bottom).offset(15)
            maker.left.right.equalTo(idField)
        }
        pwField.returnKeyType = .done

        idField.delegate = self
        pwField.delegate = self

        return (idField, pwField)
    }
    
    private func buildLoginButton(idField: UITextField, pwField: UITextField) -> (UIButton) {
        let loginButton = UIButton()
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
                self?.listener?.login(withLoginModel: LoginModel())
            }).disposed(by: disposeBag)

        return loginButton
    }
    
    private func buildETCField(below loginButton: UIButton) {
        let goSignUpButton = UIButton()
        view.addSubview(goSignUpButton)
        goSignUpButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(loginButton.snp.bottom).offset(20)
            maker.left.equalTo(loginButton.snp.left).inset(40)
            maker.height.equalTo(20)
        }
        goSignUpButton.setTitle("회원가입", for: .normal)
        goSignUpButton.setTitleColor(UIColor.black, for: .normal)
        goSignUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        goSignUpButton.setTitleColor(UIColor.gray, for: .normal)

        let skipButton = UIButton()
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(loginButton.snp.bottom).offset(20)
            maker.right.equalTo(loginButton.snp.right).inset(40)
            maker.height.equalTo(20)
        }
        skipButton.setTitle("비회원으로", for: .normal)
        skipButton.setTitleColor(UIColor.black, for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        skipButton.setTitleColor(UIColor.gray, for: .normal)
        skipButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.login(withLoginModel: LoginModel())
            }).disposed(by: disposeBag)
    }
    
    private func customTextField() -> TextFieldWithPadding {
        let myTextField = TextFieldWithPadding()
        myTextField.layer.cornerRadius = 4
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.borderColor = UIColor.gray.cgColor
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
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
