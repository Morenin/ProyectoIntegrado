//
//  ImageTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 12/5/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    private var task: URLSessionTask?
    static let identifier: String = "imageDetailCustomCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func style() {
        subTitleLabel.loadStyleLabelFontOpenSasSmall()
        subTitleLabel.textColor = .black60
    }
    
    func loadData(image: URL, text: String) {
        subTitleLabel.text = text
        task = newImage.loadImageUsingCache(withUrl: image.absoluteString)
    }
}
