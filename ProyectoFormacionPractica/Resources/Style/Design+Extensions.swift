//
//  Design+Extensions.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 21/4/21.
//

import Foundation
import UIKit


@objc extension UIColor {
    static let blueSdos: UIColor = UIColor(red: 31/255, green: 155/255, blue: 222/255, alpha: 1.0)
    static let SdosAlpha: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
    static let blueDark: UIColor = UIColor(red: 18/255, green: 79/255, blue: 122/255, alpha: 1.0)
    static let whiteThree: UIColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    static let black60: UIColor = UIColor(red: 0/255, green: 0/255, blue: 10/255, alpha: 0.6)
    static let black90: UIColor = UIColor(red: 0/255, green: 0/255, blue: 10/255, alpha: 0.9)
    static let blueSdos8: UIColor = UIColor(red: 31/255, green: 155/255, blue: 222/255, alpha: 0.08)
    static let black40: UIColor = UIColor(red: 0/255, green: 0/255, blue: 10/255, alpha: 0.4)
}
@objc extension UIView {
    func loadStyleColor() {
        self.backgroundColor = UIColor.blueSdos
    }
    func loadStylerColorFoundGris() {
        self.backgroundColor = UIColor.whiteThree
    }
}

@objc extension UILabel {
    func loadStyleLabelFontOpenSasBoldBig() {
        self.font = UIFont(name: self.font.fontName, size: FontSize.big.rawValue)
    }
    func loadStyleLabelFontOpenSasBoldNormal() {
        self.font = UIFont(name: self.font.fontName, size: FontSize.normal.rawValue)
    }
    func loadStyleLabelFontOpenSasRegularSmall() {
        self.font = UIFont(name: self.font.fontName, size: FontSize.small.rawValue)
    }
    func loadStyleLabelFontOpenSasNormalSmall() {
        self.font = UIFont(name: self.font.fontName, size: FontSize.normalSmall.rawValue)
    }
    func loadStyleLabelFontOpenSasSmall() {
        self.font = UIFont(name: self.font.fontName, size: FontSize.verySamall.rawValue)
    }
}

@objc extension UINavigationBar {
    func loadStyleNavigationBarForgotPassword() {
        self.barTintColor = UIColor.blueSdos
        self.isTranslucent = false
        self.tintColor = UIColor .white
        self.topItem?.title = ""
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
    }
    
    func loadStyleNavigationBarListWithImages() {
        self.loadStyleNavigationBarForgotPassword()
    }
}

@objc extension UINavigationItem {
    func loadstyleIconSearchRight() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        self.rightBarButtonItem?.tintColor = .white
        self.rightBarButtonItem = rightBarButton
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.leftBarButtonItem = leftBarButton
    }
}

@objc extension UIButton {
    func loadStyleButtonColorDark() {
        self.backgroundColor = UIColor.blueDark
    }
    func loadStyleShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.1
    }
    func loadStyleIcon() {
        self.loadStyleShadow()
        self.backgroundColor = .white
        self.tintColor = .gray
    }
}

@objc extension UITextField {
    func loadStyleTextFieldColor() {
        self.backgroundColor = UIColor.SdosAlpha
    }
    
    func loadStyleTextFiledColorWhite() {
        self.backgroundColor = .white
    }
    
    func loadStyleForm() {
        self.loadStyleTextFiledColorWhite()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.1
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        self.leftView = padding
        self.leftViewMode = UITextField.ViewMode.always
    }
}

@objc extension UIAlertController {
    static func alertBasic( title: String, message: String) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
}

@objc extension UIAlertAction {
    static func actionConfir() -> UIAlertAction {
        return UIAlertAction(title: "Confirmar", style: .default, handler: nil)
    }
    static func actionCancel() -> UIAlertAction {
        return UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
    }
}


@objc extension UIImageView {
    func loadStyleShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.1
    }
}

@objc extension DateFormatter {
    static func dateFormatterTime() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        formatter.locale = Locale(identifier: "es")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return formatter
    }
    
    static func dateFormatterDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "es")
        formatter.setLocalizedDateFormatFromTemplate("ddMMMMyy")
        return formatter
    }

}
