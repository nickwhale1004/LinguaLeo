//
//  AppDelegate.swift
//  LinguaLeo
//
//  Created by Никита Шляхов on 02.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let vc = PlayersViewController(viewModel: PlayersViewModel())
		let vcNavigation = UINavigationController(rootViewController: vc)
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = vcNavigation
		window?.makeKeyAndVisible()
		
		return true
	}
}

