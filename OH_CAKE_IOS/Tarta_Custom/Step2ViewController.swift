//
//  Step2ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 10/5/22.
//

import UIKit

class Step2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var size = ""
    @IBOutlet weak var formacollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        formacollection.delegate = self
        formacollection.dataSource = self
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formacell", for: indexPath) as! FormaCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Capturar aqui que boton ha pulsado
        
    }
    

}
