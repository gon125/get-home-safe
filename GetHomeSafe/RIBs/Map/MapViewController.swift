//
//  MapViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import NMapsMap
import Combine

final class MapViewController: UIViewController, MapViewControllable, NMFMapViewCameraDelegate {
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(floatingActionsView: ViewControllable) {
        addChild(floatingActionsView.uiviewController)
        view.addSubview(floatingActionsView.uiviewController.view)
        floatingActionsView.uiviewController.view.snp.makeConstraints {
            $0.bottom.equalTo(view.snp_bottom).inset(15)
            $0.width.equalTo(view.snp_width).inset(30)
            $0.centerX.equalTo(view.snp_centerX)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    // MARK: - Private
    lazy var naverMapView = NMFNaverMapView(frame: view.frame)
    private lazy var locationControlView = NMFLocationButton()
    private(set) var viewModel: ViewModel
    
    private func setupMap() {
        viewModel.setupMap()
        view.addSubview(naverMapView)
        view.addSubview(locationControlView)
        locationControlView.mapView = naverMapView.mapView
        locationControlView.snp.makeConstraints {
            $0.bottom.equalTo(naverMapView.snp.bottom).inset(120)
            $0.left.equalTo(naverMapView.snp.left).inset(10)
        }
        naverMapView.mapView.logoAlign = .rightTop
        if let currentLocation = viewModel.currentLocation {
            naverMapView.mapView.moveCamera(.init(scrollTo: NMGLatLng(from: currentLocation.coordinate)))
        }
        
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        viewModel.cameraLocationChanged()
    }
}

#if DEBUG
import SwiftUI

struct MapVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        MapViewController(viewModel: .init())
    }
}

@available(iOS 13.0.0, *)
struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapVCRepresentable()
    }
}
#endif
