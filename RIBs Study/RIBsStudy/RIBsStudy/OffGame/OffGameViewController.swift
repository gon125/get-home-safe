//
//  OffGameViewController.swift
//  RIBsStudy
//
//  Created by Geonhyeong LIm on 2021/04/01.
//

import RIBs
import SnapKit
import UIKit
import RxCocoa
import RxSwift

protocol OffGamePresentableListener: class {
    func startGame()
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    var uiviewController: UIViewController {
        return self
    }

    weak var listener: OffGamePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        buildStartButton()
    }
    
    private func buildStartButton() {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.snp.makeConstraints { maker in
            maker.center.equalTo(self.view.snp.center)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(100)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .black
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.startGame()
            })
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
