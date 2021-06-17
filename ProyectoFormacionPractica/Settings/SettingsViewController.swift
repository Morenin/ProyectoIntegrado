//
//  SettingsViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 5/6/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonNoti: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonChanged: UIButton!
    @IBOutlet weak var buttonExit: UIButton!
    @IBOutlet weak var viewExtra: UIView!
    private var email: String
    
    init( email: String) {
        self.email = email
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no ha sido implementado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }

    
    @IBAction func buttonActionNoti(_ sender: Any) {
        let notification = NotificationsViewController()
        navigationController?.pushViewController(notification, animated: true)
    }
    
    @IBAction func buttonActionEdit(_ sender: Any) {
        let edit = EditProfileViewController(email: email)
        navigationController?.pushViewController(edit, animated: true)
    }
    
    @IBAction func buttonActionChanged(_ sender: Any) {
        let changePassword = ChangePasswordViewController()
        navigationController?.pushViewController(changePassword, animated: true)
    }
    
    @IBAction func buttonActionExit(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let login = LoginViewController()
            self.navigationController?.pushViewController(login, animated: true)
            let alertController = UIAlertController(title: "Cerrar sesion", message: "Se ha cerrado sesion correctamente", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } catch {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func style() {
        buttonNoti.backgroundColor = .blueSdos
        buttonNoti.tintColor = .white
        buttonEdit.backgroundColor = .blueSdos
        buttonEdit.tintColor = .white
        buttonChanged.backgroundColor = .blueSdos
        buttonChanged.tintColor = .white
        buttonExit.backgroundColor = .blueSdos
        buttonExit.tintColor = .white
    }
}
