//
//  RegisterViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/6/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textRepeatPassword: UITextField!
    @IBOutlet weak var outletSend: UIButton!
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }

    @IBAction func actionButtonSend(_ sender: Any) {
        if let email = textEmail.text, let password = textPassword.text, let repeatpasswor = textRepeatPassword.text, let name = textName.text {
            if password == repeatpasswor {
                db.collection("User").document(email).setData([
                    "name": name,
                    "password": password
                ])
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let result = result, error == nil {
                        let login = LoginViewController()
                        self.navigationController?.pushViewController(login, animated: true)
                        let alertController = UIAlertController(title: "Registro", message: "Te has registrado correctamente", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "Se ha producido un error, comprueba que ambas contraseña son iguales", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            } else  {
                let alertController = UIAlertController(title: "Error", message: "No coinciden las contraseñas", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func style() {
        view.loadStyleColor()
        labelTitle.loadStyleLabelFontOpenSasBoldBig()
        textName.loadStyleTextFieldColor()
        textEmail.loadStyleTextFieldColor()
        textPassword.loadStyleTextFieldColor()
        textRepeatPassword.loadStyleTextFieldColor()
        outletSend.titleLabel?.loadStyleLabelFontOpenSasBoldNormal()
        outletSend.backgroundColor = .blueDark
        outletSend.tintColor = .white
        outletSend.setTitle("Enviar", for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
