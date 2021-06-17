//
//  AppDelegate.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 20/4/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds )
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigation = UINavigationController(rootViewController: login)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }


    

}

