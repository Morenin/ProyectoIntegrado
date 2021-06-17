//
//  ImageTitleTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 18/5/21.
//

import UIKit

class ImageTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTitle: UIImageView!
    private var task: URLSessionTask?
    static let identifier: String = "imageTitleDetailCustomCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(image: URL){
        task = imageTitle.loadImageUsingCache(withUrl: image.absoluteString)
    }
}
