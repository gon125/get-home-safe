//
//  FloatingActionsViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import Combine
import SwiftUI

protocol FloatingActionsPresentableListener: class {
    func searchRoute()
    func showCCTVMarkers()
    func showPoliceStationMarkers()
    func showHotPlaceMarkers()
    func dismissCCTVMarkers()
    func dismissPoliceStationMarkers()
    func dismissHotPlaceMarkers()
}

final class FloatingActionsViewController: UIViewController, FloatingActionsPresentable, FloatingActionsViewControllable {
     
    weak var listener: FloatingActionsPresentableListener?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        buildFloatingPanel()
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
    
    private lazy var cctvButton: UIButton = {
        let button = UIToggleButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("CCTV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            button.toggle()
            if button.isOn {
                self?.listener?.showCCTVMarkers()
            } else {
                self?.listener?.dismissCCTVMarkers()
            }
        }).disposed(by: disposeBag)
        return button
    }()
    private lazy var policeStationButton: UIButton = {
        let button = UIToggleButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("치안센터", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            button.toggle()
            if button.isOn {
                self?.listener?.showPoliceStationMarkers()
            } else {
                self?.listener?.dismissPoliceStationMarkers()
            }
        }).disposed(by: disposeBag)
        return button
    }()
    private lazy var hotPlacesButton: UIButton = {
        let button = UIToggleButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle("번화가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            button.toggle()
            if button.isOn {
                self?.listener?.showHotPlaceMarkers()
            } else {
                self?.listener?.dismissHotPlaceMarkers()
            }
        }).disposed(by: disposeBag)
        return button
    }()
    private lazy var searchRouteButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .cyan
        button.setTitle("길찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.rx.tap.subscribe(onNext: { [weak self] in
        }).disposed(by: disposeBag)
        return button
    }()

    private lazy var floatingPanel: UIView = {
        let box = UIView()
        box.layer.shadowOffset = .zero
        box.layer.shadowColor = UIColor.black.cgColor
        box.layer.shadowOpacity = 1
        box.backgroundColor = .white
        return box
    }()
    
    private func buildFloatingPanel() {
        view.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        view.addSubview(floatingPanel)
        floatingPanel.snp.makeConstraints {
            $0.width.equalTo(view)
            $0.centerX.equalTo(view.snp_centerX)
            $0.height.equalTo(80)
            $0.bottom.equalTo(view)
        }
        buildButtons()
    }
    private func buildButtons() {
        floatingPanel.addSubview(cctvButton)
        cctvButton.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(floatingPanel.snp_height).inset(10)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
            $0.leading.equalTo(10)
        }
        
        floatingPanel.addSubview(policeStationButton)
        policeStationButton.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(floatingPanel.snp_height).inset(10)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
            $0.left.equalTo(cctvButton.snp_right).offset(10)
        }
        
        floatingPanel.addSubview(hotPlacesButton)
        hotPlacesButton.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(floatingPanel.snp_height).inset(10)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
            $0.left.equalTo(policeStationButton.snp_right).offset(10)
        }
        
        floatingPanel.addSubview(searchRouteButton)
        searchRouteButton.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(floatingPanel.snp_height).inset(10)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
            $0.left.equalTo(hotPlacesButton.snp_right).offset(10)
        }
    }
}

#if DEBUG
import SwiftUI

struct FloatingActionsVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = FloatingActionsViewController()
        
        vc.view.snp.makeConstraints {
            $0.width.equalTo(340)
        }
        return vc
        
    }
}

@available(iOS 13.0.0, *)
struct FloatingActions_Previews: PreviewProvider {
    static var previews: some View {
        FloatingActionsVCRepresentable()
    }
}
#endif
