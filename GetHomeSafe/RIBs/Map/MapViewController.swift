//
//  MapViewController.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI
import NMapsMap

protocol MapPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MapViewController: UIViewController, MapPresentable, MapViewControllable {
    weak var listener: MapPresentableListener?
    override func viewDidLoad() {
        view.addSubview(naverMapView)
    }
    
    // MARK: - Private
    private lazy var naverMapView = NMFNaverMapView(frame: view.frame)
}

#if DEBUG
import SwiftUI

struct MapVCRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        MapViewController()
    }
}

@available(iOS 13.0.0, *)
struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapVCRepresentable()
    }
}
#endif
