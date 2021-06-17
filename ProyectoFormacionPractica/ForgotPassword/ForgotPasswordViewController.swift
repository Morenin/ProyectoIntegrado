//
//  ForgotPasswordViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 20/4/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var textEmail: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var buttonSubmitOutlet: UIButton!
    
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStyle()
        view.loadStyleColor()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textEmail.delegate = self
    }
    
    @IBAction func buttonSubmit(_ sender: Any) {
        alertConfirm()
    }
   
    func alertConfirm() {
        if let email = textEmail.text, isValidEmail(string: email) {
            correctEmail(email: email)
        } else {
            failedEmail()
        }
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    func correctEmail(email: String) {
        let alert = UIAlertController(title: "Confirmacion de email", message: "¿El Email \(email) es correcto?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Confirmar", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func failedEmail() {
        let alert1 = UIAlertController(title: "Error", message: "Por favor inserta un email valido", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert1.addAction(action1)
        present(alert1, animated: true, completion: nil)
    }
    
    func loadStyle() {
        titleLabel.loadStyleLabelFontOpenSasBoldBig()
        titleLabel.text = "¿No recuerdas la contraseña?"
        subTitleLabel.loadStyleLabelFontOpenSasRegularSmall()
        subTitleLabel.text = "Introduce el email y te enviaremos un enlace de restablecimiento"
        buttonSubmitOutlet.titleLabel?.text = "Enviar"
        buttonSubmitOutlet.titleLabel?.loadStyleLabelFontOpenSasBoldNormal()
        buttonSubmitOutlet.loadStyleButtonColorDark()
        textEmail.loadStyleTextFieldColor()
        navigationController?.navigationBar.loadStyleNavigationBarForgotPassword()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
        if let activeTextField = textEmail {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
          }
          if(shouldMoveViewUp) {
            self.view.frame.origin.y -= keyboardSize.height
          }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y += keyboardSize.height
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
      }

      func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
      }
}
