//
//  RouteRequestViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import RIBs
import RxSwift
import UIKit

protocol RouteRequestPresentableListener: class {
    func searchRoute(start: String?, destination: String)
}

final class RouteRequestViewController: UIViewController, RouteRequestPresentable, RouteRequestViewControllable {
    func dismiss() {
        dismiss(animated: true)
    }
    
    weak var listener: RouteRequestPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUpperView()
        view.backgroundColor = UIColor.white
    }
    
    private func makeUpperView() {
        let upperView = UIView()
        upperView.backgroundColor = UIColor(displayP3Red: 123/255, green: 162/255, blue: 239/255, alpha: 1)
        view.addSubview(upperView)
        upperView.snp.makeConstraints {(maker)in
            maker.top.equalTo(self.view)
            maker.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(160)
        }
        
        var sourceField: UITextField
        var destField: UITextField
        
        (sourceField, destField) = makeTextField(upperView)
        makeImageButton(sourceField, destField)
    }
    
    private func makeTextField(_ upperView: UIView) -> (UITextField, UITextField) {
        let sourceField = customTextField()
        sourceField.placeholder = "출발지 : 현재 위치"
        view.addSubview(sourceField)
        sourceField.snp.makeConstraints {(maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            maker.left.equalTo(upperView).offset(15)
            maker.width.equalTo(upperView.snp.width).inset(40)
            maker.height.equalTo(40)
        }
        
        let destField = customTextField()
        destField.placeholder = "도착지"
        view.addSubview(destField)
        destField.snp.makeConstraints { (maker) in
            maker.top.equalTo(sourceField.snp.bottom).offset(10)
            maker.left.equalTo(upperView).offset(15)
            maker.width.equalTo(upperView.snp.width).inset(40)
            maker.height.equalTo(40)
        }
        
        return (sourceField, destField)
    }
    
    private func makeImageButton(_ sourceField: UITextField, _ destField: UITextField) {
        let cancleButton = UIButton()
        let cancleImg: UIImage = .init(named: "letter-x")!
        
        cancleButton.setImage(cancleImg, for: .normal)
        view.addSubview(cancleButton)
        cancleButton.snp.makeConstraints {(maker)in
            maker.top.equalTo(sourceField.snp.top).offset(5)
            maker.left.equalTo(sourceField.snp.right).offset(10)
            maker.width.equalTo(30)
            maker.bottom.equalTo(sourceField.snp.bottom).inset(5)
        }
        cancleButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    
        let naviButton = UIButton()
        let naviImg: UIImage = .init(named: "magnifying-glass")!

        naviButton.setImage(naviImg, for: .normal)
        view.addSubview(naviButton)
        naviButton.snp.makeConstraints {(maker)in
            maker.top.equalTo(destField.snp.top).offset(5)
            maker.left.equalTo(destField.snp.right).offset(10)
            maker.width.equalTo(30)
            maker.bottom.equalTo(destField.snp.bottom).inset(5)
        }
        naviButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let destination = destField.text, destination != "" else { return }
            self?.listener?.searchRoute(start: sourceField.text == "" ? nil : sourceField.text, destination: destination)
        }).disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
    
    private func customTextField() -> TextFieldWithPadding {
        let myTextField = TextFieldWithPadding()
        myTextField.layer.cornerRadius = 4
        myTextField.layer.borderWidth = 0.5
        myTextField.layer.borderColor = UIColor.white.cgColor
        myTextField.backgroundColor = UIColor.white
        myTextField.attributedPlaceholder = NSAttributedString(string: "Placeholder Color", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)/*, NSAttributedString.Key.foregroundColor : UIColor.darkGray*/])
        myTextField.textColor = UIColor.darkGray

        return myTextField
    }
}

#if DEBUG
import SwiftUI

struct RouteRequestVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        RouteRequestViewController()
    }
}

@available(iOS 13.0.0, *)
struct RouteRequest_Previews: PreviewProvider {
    static var previews: some View {
        RouteRequestVCRepresentable()
    }
}
#endif
