//
//  FormViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 28/4/21.
//

import UIKit
import CoreLocation
import FirebaseFirestore

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var pickerView = UIPickerView()
    var toolbarView = UIToolbar()
    let myPikcerData = ["Deporte", "Economia", "Sanidad", "Moda"]
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var imagePicker = UIImagePickerController()
    let camera = UIImage(named: "default_image")
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var activeTextField: UITextField? = nil
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var labelDropdown: UILabel!
    @IBOutlet weak var textFieldDropdown: UITextField!
    @IBOutlet weak var buttonDropdownOutlet: UIButton!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var buttonAddressOutlet: UIButton!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var textFieldDate: UITextField!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var textFieldTime: UITextField!
    
    @IBOutlet weak var labelImage: UILabel!
    @IBOutlet weak var imagePhoto: UIImageView!
    
    @IBOutlet weak var buttonSubmitOutlet: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let db = Firestore.firestore()
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
        createDatePicker()
        createTimePicker()
        style()
        actionImage()
        notificationKeyboard()
        hideKeyboard()
    }
    
    @IBAction func buttonSubmit(_ sender: Any) {
        if textFieldDropdown.text != "" && textFieldTime.text != "" && textFieldAddress.text != "" && textFieldName.text != "" && imagePhoto != camera {
            db.collection("news").document(email).setData([
                                                                            "tipo": textFieldDropdown.text!,
                                                                            "hora": textFieldDate.text!,
                                                                            "fecha": textFieldTime.text!,
                                                                            "direccion": textFieldAddress.text!,
                                                                            ])
            let alert = UIAlertController.alertBasic(title: "Aceptado", message: "Datos guardado correctamente")
            let action = UIAlertAction.actionConfir()
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        let alert = UIAlertController.alertBasic(title: "Error", message: "Tienes campos sin rellenar")
        let action = UIAlertAction.actionConfir()
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonAddress(_ sender: Any) {
        locationManager.delegate = self
        locationPermissions()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            textFieldLocation(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController.alertBasic(title: "Error", message: error.localizedDescription)
        let action = UIAlertAction.actionConfir()
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func locationPermissions() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            let alert = UIAlertController.alertBasic(title: "Error", message: "Acceso restringido")
            let action = UIAlertAction.actionConfir()
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        case .denied:
            let alert = UIAlertController.alertBasic(title: "Error", message: "Acceso a localizacion denegado")
            let actionCancel = UIAlertAction.actionCancel()
            let action = UIAlertAction.actionConfir()
            alert.addAction(action)
            alert.addAction(actionCancel)
            present(alert, animated: true, completion: nil)
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            let alert = UIAlertController.alertBasic(title: "Error", message: "Algo ha salido mal")
            let action = UIAlertAction.actionConfir()
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldLocation(location: CLLocation){
        geocoder.reverseGeocodeLocation(location) {(placemark, error) in
            if let error = error {
                print(error)
            }
            guard let placemark = placemark?.first else { return }
            guard let streetNumber = placemark.subThoroughfare else { return }
            guard let streetName = placemark.thoroughfare else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
            self.textFieldAddress.text = "\(streetNumber) \(streetName) \(city) \(state)"
        }
    }
    
    @IBAction func buttonDropdown(_ sender: Any) {
        pickerView = UIPickerView.init()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(pickerView)
        toolbarView = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolbarView.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolbarView)
        buttonDropdownOutlet.isUserInteractionEnabled = false
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPikcerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldDropdown.text = myPikcerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPikcerData[row]
    }
    
    func createDatePicker() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressedDate))
        datePicker.datePickerMode = .date
        createDatePikcerGlobal(picker: datePicker, textField: textFieldDate, doneButton: doneButton)
    }
    
    func createTimePicker() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressedTime))
        timePicker.datePickerMode = .time
        createDatePikcerGlobal(picker: timePicker, textField: textFieldTime, doneButton: doneButton)
    }
    
    func createDatePikcerGlobal(picker: UIDatePicker, textField: UITextField, doneButton: UIBarButtonItem){
        picker.locale = Locale(identifier: "es")
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = picker
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
    }
    
    @objc func donePressedDate() {
        let formatter = DateFormatter.dateFormatterDate()
        textFieldDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func donePressedTime() {
        let formatter1 = DateFormatter.dateFormatterTime()
        textFieldTime.text = formatter1.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func onDoneButtonTapped() {
        pickerView.removeFromSuperview()
        toolbarView.removeFromSuperview()
        buttonDropdownOutlet.isUserInteractionEnabled = true
    }
    
    func actionImage() {
        let image = UITapGestureRecognizer(target: self, action: #selector(photoFunc))
        imagePhoto.isUserInteractionEnabled = true
        imagePhoto.addGestureRecognizer(image)
    }
    
    @objc func photoFunc() {
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
            imagePicker.delegate = self
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
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePhoto.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func style(){
        self.view.loadStylerColorFoundGris()
        //Text Field
        textFieldName.loadStyleForm()
        textFieldDate.loadStyleForm()
        textFieldTime.loadStyleForm()
        textFieldDropdown.loadStyleForm()
        textFieldDropdown.isEnabled = false
        textFieldAddress.loadStyleForm()
        textFieldAddress.isEnabled = false
        //Image View
        imagePhoto.image = camera
        imagePhoto.contentMode = .scaleAspectFill
        imagePhoto.layer.masksToBounds = true
        imagePhoto.loadStyleShadow()
        //Button submit
        buttonSubmitOutlet.backgroundColor = .blueSdos
        buttonSubmitOutlet.tintColor = .white
        buttonSubmitOutlet.setTitle("Enviar", for: UIControl.State.normal)
        //Navigation bar
        self.navigationController?.navigationBar.loadStyleNavigationBarForgotPassword()
        self.navigationItem.title = "Formulario"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "CANCELAR", style: .plain, target: self, action: #selector(buttonCancel))
        leftBarButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarButton
        //Button addres y dropdown
        let icoMap = UIImage(named:"map")
        buttonAddressOutlet.setImage(icoMap, for: .normal)
        buttonAddressOutlet.loadStyleIcon()
        let icoArrow = UIImage(named: "arrow")
        buttonDropdownOutlet.setImage(icoArrow, for: .normal)
        buttonDropdownOutlet.loadStyleIcon()
    }
    
    @objc func buttonCancel() {
        let alert = UIAlertController.alertBasic(title: "Confirmacion", message: "¿Los datos no guardado se perderan estas deacuerdo?")
        let cancelAction = UIAlertAction.actionCancel()
        let okAction = UIAlertAction(title: "Confirmar", style: .default) { (action) in self.removeAll() }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func removeAll() {
        textFieldName.text?.removeAll()
        textFieldDate.text?.removeAll()
        textFieldTime.text?.removeAll()
        textFieldAddress.text?.removeAll()
        textFieldDropdown.text?.removeAll()
        imagePhoto.image = camera
    }
    
    func notificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboard() {
        let tap =  UITapGestureRecognizer(target: self, action: #selector(dismisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismisKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    
}

