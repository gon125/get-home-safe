//
//  SignUpViewController.swift
//  GetHomeSafe
//
//  Created by khs on 2021/05/20.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpPresentableListener: AnyObject {
    func signUp(phoneNum: String?, newID: String?, newPW: String?)
}

final class SignUpViewController: UIViewController, SignUpPresentable, SignUpViewControllable {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let userFields = buildLoginFields()
        buildSignUpButton(phoneField: userFields.phoneField, idField: userFields.1.idField, pwField: userFields.1.pwField)
    }

    private var phoneField: UITextField?
    private var idField: UITextField?
    private var pwField: UITextField?
    private var signUpButton: UIButton?

    private func buildLoginFields() -> (phoneField: UITextField, (idField: UITextField, pwField: UITextField)) {
        let emptySpace = UIView()
        view.addSubview(emptySpace)
        emptySpace.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view)
            maker.height.equalTo(135 * view.frame.width / 320)
        }

        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.text = "회원가입"
        titleLabel.font = UIFont.init(name: "AppleSDGothicNeo-Bold", size: 20.0)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view).offset(160)
            maker.leading.trailing.equalTo(self.view).inset(40)
        }

        let phoneField = customTextField()
        self.phoneField = phoneField
        view.addSubview(phoneField)
        phoneField.placeholder = "휴대폰 번호"
        phoneField.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(18)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(38 * view.frame.width / 320)
        }
        phoneField.returnKeyType = .next

        let idField = customTextField()
        self.idField = idField
        view.addSubview(idField)
        idField.placeholder = "아이디"
        autoLayout(idField, below: phoneField, offset: 18)
        idField.returnKeyType = .next

        let pwField = customTextField()
        self.pwField = pwField
        view.addSubview(pwField)
        pwField.placeholder = "비밀번호"
        autoLayout(pwField, below: idField, offset: 15)
        pwField.returnKeyType = .done

        phoneField.delegate = self
        idField.delegate = self
        pwField.delegate = self

        return (phoneField, (idField, pwField))
    }

    private func buildSignUpButton(phoneField: UITextField, idField: UITextField, pwField: UITextField) {
        let signUpButton = UIButton()
        self.signUpButton = signUpButton
        signUpButton.layer.cornerRadius = 3
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(pwField.snp.bottom).offset(20)
            maker.left.right.height.equalTo(phoneField)
        }
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.backgroundColor = UIColor.init(red: (123)/255, green: (162)/255, blue: (239)/255, alpha: 1.0)
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.signUp(phoneNum: phoneField.text, newID: idField.text, newPW: pwField.text)
            }).disposed(by: disposeBag)
    }

    weak var listener: SignUpPresentableListener?
    private let disposeBag = DisposeBag()

    private func customTextField() -> TextFieldWithPadding {
        let myTextField = TextFieldWithPadding()
        myTextField.layer.cornerRadius = 4
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.borderColor = UIColor.gray.cgColor
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        myTextField.textColor = UIColor.gray

        return myTextField
    }

    private func autoLayout(_ Field: TextFieldWithPadding, below: TextFieldWithPadding, offset: Double) {
        Field.snp.makeConstraints { (maker) in
            maker.top.equalTo(below.snp.bottom).offset(offset)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.left.right.height.equalTo(below)
        }
    }
    
    @objc private func didTapLoginButton() {

    }
}

extension SignUpViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneField {
            idField?.becomeFirstResponder()
        } else if textField == idField {
            idField?.resignFirstResponder()
            pwField?.becomeFirstResponder()
        } else {
            pwField?.resignFirstResponder()
        }
        return true
    }
}
