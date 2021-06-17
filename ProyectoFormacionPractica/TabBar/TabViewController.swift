//
//  TabViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 7/6/21.
//

import UIKit

class TabViewController: UITabBarController {

    var email: String = ""
    
    init( email: String) {
        self.email = email
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no ha sido implementado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = .blueSdos
        self.viewControllers = [news(), collection(), form(), settings()]
        self.tabBar.backgroundColor = .blueSdos
    }

    func news() -> UIViewController {
        let view = ListWithImagesViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        return UINavigationController(rootViewController: view)
    }

    func collection() -> UIViewController {
        let view = CollectionListWithImagesViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        return UINavigationController(rootViewController: view)
    }

    func form() -> UIViewController {
        let view = FormViewController(email: email)
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        return UINavigationController(rootViewController: view)
    }

    func settings() -> UIViewController {
        let view = SettingsViewController(email: email)
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        return UINavigationController(rootViewController: view)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
}
