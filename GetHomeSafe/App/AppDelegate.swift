//
//  AppDelegate.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/15.
//
import RIBs
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DIContainer.registerDependencies()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension DIContainer {
    static func registerDependencies() {
        DIContainer.shared.register(DefaultCCTVUseCase(repository: DefaultCCTVRepository()) as CCTVUseCase)
        DIContainer.shared.register(DefaultHotPlaceUseCase() as HotPlaceUseCase)
        DIContainer.shared.register(DefaultPoliceStationUseCase(repository: DefaultPoliceStationRepository()) as PoliceStationUseCase)
        DIContainer.shared.register(DefaultAuthenticationUseCase() as AuthenticationUseCase)
        DIContainer.shared.register(DefaultSearchRouteUseCase(routeRepository: DefaultRouteRepository(), locationRepository: DefaultLocationRepository()) as SearchRouteUseCase)
    }
}
