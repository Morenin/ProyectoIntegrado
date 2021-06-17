//
//  CellListTableViewCell.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 4/5/21.
//

import UIKit

class CellListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageNew: UIImageView!
    @IBOutlet weak var labelNews: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var buttonFavOutlet: UIButton!
    let icon = UIImage(named: "fav")
    private var task: URLSessionTask?
    var fav: Bool = false
    
    var tags: [String] = [] {
        didSet {
            tagCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageNew.image = nil
        task?.cancel()
        task = nil
    }
    
    @IBAction func buttonFavAction(_ sender: Any) {
        if fav == false {
            buttonFavOutlet.tintColor = .yellow
            fav = true
        } else {
            buttonFavOutlet.tintColor = .black
            fav = false
        }
        
    }
    
    
    func registerCollectionView() {
        self.tagCollectionView.register(UINib(nibName: "CellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagCell")
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        if let collectionViewLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func style() {
        labelDate.textColor = .black60
        labelDate.loadStyleLabelFontOpenSasSmall()
        labelNews.textColor = .black90
        labelDate.loadStyleLabelFontOpenSasNormalSmall()
       
    }
    
    func setDate(new: News) {
        let date = new.date
        labelDate.text = changeDateFormat(date: date, format: "d MMMM").uppercased()
        labelNews.text = new.title
        task = imageNew.loadImageUsingCache(withUrl: new.image)
        imageNew.contentMode = .scaleToFill
        tags = new.tags
    }
    
}

extension CellListTableViewCell:  UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? CellCollectionViewCell {
            cell.labelCollection.text = tags[indexPath.row].capitalizingFirstLetter()
            cell.labelCollection.textColor = .blueSdos
            cell.viewCollection.backgroundColor = .blueSdos8
            return cell
        }
        fatalError("No hay tag")
    }
}


