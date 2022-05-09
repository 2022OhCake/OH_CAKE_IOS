//
//  CategoriasViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 6/5/22.
//

import UIKit

class CategoriasViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let categorias = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaCategorias", for: indexPath) as! CategoriasCell
        
        return cell
    }
    
    
    
    

}
