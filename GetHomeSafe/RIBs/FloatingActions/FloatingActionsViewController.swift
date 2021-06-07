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
import SVGKit

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
        let cctvSVG: SVGKImage = SVGKImage(named: "camera")
        let cctvImg: UIImage = cctvSVG.uiImage

        button.setImage(cctvImg, for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1
        
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
        let policSVG: SVGKImage = SVGKImage(named: "police-station")
        let policeImg: UIImage = policSVG.uiImage

        button.setImage(policeImg, for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1
        
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
        let roadSVG: SVGKImage = SVGKImage(named: "road")
        let roadImg: UIImage = roadSVG.uiImage

        button.setImage(roadImg, for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1
        
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
        let naviSVG: SVGKImage = SVGKImage(named: "navigation")
        var naviImg: UIImage = naviSVG.uiImage
        naviImg = naviImg.withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.white

        button.setImage(naviImg, for: .normal)
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1
        // button.backgroundColor = UIColor.init(red: 112/255, green: 160/255, blue: 237/255, alpha: 1)
        
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
        floatingPanel.layer.cornerRadius = 4
        buildButtons()
    }
    
    private func buildButtons() {
        let policeSection = UIView()
        floatingPanel.addSubview(policeSection)
        policeSection.snp.makeConstraints {
            $0.width.equalTo(55)
            $0.right.equalTo(floatingPanel.snp.centerX).inset(-10)
            $0.height.equalTo(floatingPanel.snp_height).inset(15)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
        }
        configureButtonSection(section: policeSection, topOffset: 0, button: policeStationButton, label: "치안센터")
        
        let cctvSection = UIView()
        floatingPanel.addSubview(cctvSection)
        cctvSection.snp.makeConstraints {
            $0.width.equalTo(55)
            $0.height.equalTo(floatingPanel.snp_height).inset(15)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
            $0.right.equalTo(policeStationButton.snp.left).inset(-25)
        }
        configureButtonSection(section: cctvSection, topOffset: 0, button: cctvButton, label: "CCTV")
        
        let hotPlacesSection = UIView()
        floatingPanel.addSubview(hotPlacesSection)
        hotPlacesSection.snp.makeConstraints {
                $0.width.equalTo(55)
                $0.left.equalTo(floatingPanel.snp.centerX).offset(10)
                $0.height.equalTo(floatingPanel.snp_height).inset(15)
                $0.centerY.equalTo(floatingPanel.snp_centerY)
            }
        configureButtonSection(section: hotPlacesSection, topOffset: 0, button: hotPlacesButton, label: "번화가")
        
        let naviSection = UIView()
        floatingPanel.addSubview(naviSection)
        naviSection.snp.makeConstraints {
            $0.width.equalTo(55)
            $0.left.equalTo(hotPlacesButton.snp_right).offset(25)
            $0.height.equalTo(floatingPanel.snp_height).inset(10)
            $0.centerY.equalTo(floatingPanel.snp_centerY)
        }
        naviSection.backgroundColor = UIColor.init(red: 112/255, green: 160/255, blue: 237/255, alpha: 1)
        naviSection.layer.cornerRadius = 4
        configureButtonSection(section: naviSection, topOffset: 5, button: searchRouteButton, label: "길찾기")
    }
    
    private func configureButtonSection(section: UIView, topOffset: Double, button: UIButton, label: String) {
        floatingPanel.addSubview(section)
        section.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(section).offset(topOffset)
            $0.width.height.equalTo(35)
            $0.centerX.equalTo(section.snp_centerX)
        }
        
        let newLabel = UITextView()
        newLabel.text = label
        newLabel.backgroundColor = UIColor.clear
        if label == "길찾기" {
            newLabel.textColor = UIColor.white
        }
        section.addSubview(newLabel)
        newLabel.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).inset(5)
            $0.width.bottom.equalTo(section)
            $0.centerX.equalTo(button.snp.centerX)
        }
        newLabel.textAlignment = .center
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
