//
//  EditProfileViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 26/5/21.
//

import UIKit
import FirebaseFirestore

class EditProfileViewController: UIViewController {

    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var changedPhoto: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDate: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    var imagePicker = UIImagePickerController()
    let camera = UIImage(named: "default_image")
    private var email: String
    private let db = Firestore.firestore()
    
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
        cargarDatos()
    }

    
    @IBAction func buttonSaveAction(_ sender: Any) {
        if let name = textName.text, let lastname = textLastName.text, let date = textDate.text{
            db.collection("User").document(email).setData([
                "name": name,
                "apellido": lastname,
                "otrosDatos": date
            ])
            let alertController = UIAlertController(title: "Guardado", message: "Los datos se han guardado correctamente", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Falta algun dato por poner", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func buttonChangeAction(_ sender: Any) {
        let alert = UIAlertController.alertBasic(title: "Elija una opcion", message: "Hacerse una foto o coger una de la galeria")
        let actionCamera = UIAlertAction(title: "Camara", style: .default ){ (action) in self.cameraButtonTapped() }
        let actionGalery = UIAlertAction(title: "Galeria", style: .default ){ (action) in self.photoButtonTapped()}
        let cancelAction = UIAlertAction.actionCancel()
        alert.addAction(actionCamera)
        alert.addAction(actionGalery)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func cameraButtonTapped() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.alertBasic(title: "Error", message: "Camara no encontrada")
            let action = UIAlertAction.actionConfir()
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func photoButtonTapped() {
        
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePhoto.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func style() {
        self.view.loadStylerColorFoundGris()
        changedPhoto.tintColor = .black
        changedPhoto.setTitle("Cambiar foto", for: UIControl.State.normal)
        textName.loadStyleForm()
        textDate.loadStyleForm()
        textLastName.loadStyleForm()
        buttonSave.loadStyleButtonColorDark()
        buttonSave.tintColor = .white
        imagePhoto.image = camera
        imagePhoto.contentMode = .scaleAspectFill
        imagePhoto.layer.masksToBounds = true
        imagePhoto.layer.cornerRadius = imagePhoto.bounds.size.width / 2.0
        imagePhoto.loadStyleShadow()
    }
    
    func cargarDatos() {
        db.collection("User").document(email).getDocument {
            (DocumentSnapshot, error) in
            
            if let document = DocumentSnapshot, error == nil {
                if let name = document.get("name") as? String {
                    self.textName.text = name
                }
                if let lastname = document.get("apellido") as? String {
                    self.textLastName.text = lastname
                }
                if let data = document.get("otrosDatos") as? String {
                    self.textDate.text = data
                }
            }
        }
    }
}
