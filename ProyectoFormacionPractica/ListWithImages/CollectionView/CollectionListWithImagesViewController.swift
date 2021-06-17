//
//  CollectionListWithImagesViewController.swift
//  ProyectoFormacionPractica
//
//  Created by Francisco José Moreno Caballero on 7/5/21.
//

import UIKit

class CollectionListWithImagesViewController: UIViewController {

    @IBOutlet weak var collectionViewList: UICollectionView!
    var news: [News] = []
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionList()
        callAPi()
        style()
    }


    func registerCollectionList() {
        self.collectionViewList.register(UINib(nibName: "CellListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "customCellCollection")
        self.collectionViewList.delegate = self
        self.collectionViewList.dataSource = self
        if let collectionViewLayout = collectionViewList.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
                }
    }
  
    func callAPi(){
        WireMockApi.apiRest(url: Url.new , success: {
            (json: List) in self.news = json.respuesta.news
            DispatchQueue.main.async {
                self.collectionViewList.reloadData()
            }
        }, failture: {_ in self.alertError()})
    }

    func alertError() {
        let alert = UIAlertController.alertBasic(title: "Error", message: "No se ha podido conectar con el servidor")
        let action = UIAlertAction.actionCancel()
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
    func style() {
        collectionViewList.backgroundColor = .whiteThree
        self.navigationController?.navigationBar.loadStyleNavigationBarForgotPassword()
        self.navigationItem.loadstyleIconSearchRight()
        self.navigationItem.title = "Lista con imágenes"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension CollectionListWithImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: "customCellCollection", for: indexPath) as? CellListCollectionViewCell {
            let new = news[indexPath.section]
            cell.setDate(new: new)
            return cell
        }
        fatalError("No hay noticias")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let diferrenceWidht = UIScreen.main.bounds.width - self.view.safeAreaLayoutGuide.layoutFrame.width  
        return CGSize( width: UIScreen.main.bounds.width - diferrenceWidht  , height: 296)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        id = news[indexPath.section].id
        let detailTable = DetailViewController(id: id)
        navigationController?.pushViewController(detailTable, animated: true)
    }
    
}
