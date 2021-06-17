//
//  LoginViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 21/4/21.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageSdos: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var buttonEnter: UIButton!
    @IBOutlet weak var buttonPassword: UIButton!
    @IBOutlet weak var registerUser: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.loadStyleColor()
        navigationController?.navigationBar.loadStyleNavigationBarForgotPassword()
        style()
        
    }

    func style() {
        let logo = UIImage(named: "logoSdos")
        imageSdos.image = logo
        buttonEnter.backgroundColor = .blueDark
        buttonEnter.tintColor = .white
        buttonEnter.setTitle("Entrar", for: UIControl.State.normal)
        buttonPassword.setTitle("Has olvidad la contraseña", for: UIControl.State.normal)
        buttonPassword.tintColor = .white
        registerUser.tintColor = .white
        registerUser.setTitle("¿No tienes cuenta?, Registrate", for: UIControl.State.normal)
    }
    @IBAction func buttonEnterAction(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let result = result, error == nil {
                    let tab = TabViewController(email: result.user.email!)
                    self.navigationController?.pushViewController(tab, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error, comprueba que el usuario y la contraseña con correcta", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
        }
    }
    
    @IBAction func buttonPasswordAction(_ sender: Any) {
        let forgotPassword = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPassword, animated: true)
    }
    
    @IBAction func registerUserAction(_ sender: Any) {
        let register = RegisterViewController()
        navigationController?.pushViewController(register, animated: true)
    }
    
    func news() -> ListWithImagesViewController {
        let view = ListWithImagesViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
//    @IBAction func ButtonAction(_ sender: Any) {
//        let forgotPassword = ForgotPasswordViewController()
//        navigationController?.pushViewController(forgotPassword, animated: true)
//    }
//
//    @IBAction func ButtonForm(_ sender: Any) {
//        let form = FormViewController()
//        navigationController?.pushViewController(form, animated: true)
//    }
//
//
//    @IBAction func ButtonActionChangedPassword(_ sender: Any) {
//        let changePassword = ChangePasswordViewController()
//        navigationController?.pushViewController(changePassword, animated: true)
//    }
//
//
//    @IBAction func CollectionView(_ sender: Any) {
//        let collectionList = CollectionListWithImagesViewController()
//        navigationController?.pushViewController(collectionList, animated: true)
//    }
//
//
//    @IBAction func buttonList(_ sender: Any) {
//        let list = ListWithImagesViewController()
//        navigationController?.pushViewController(list, animated: true)
//    }
//
//    @IBAction func buttonNotification(_ sender: Any) {
//        let notification = NotificationsViewController()
//        navigationController?.pushViewController(notification, animated: true)
//    }
}
