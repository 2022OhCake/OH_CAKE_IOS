//
//  ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Practica_libre on 16/3/22.
//

import UIKit
//Comprobar fittedSheets -> https://github.com/gordontucker/FittedSheets
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   
    @IBOutlet weak var ofertasCollection: UICollectionView!
    @IBOutlet weak var mejorCollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ofertasCollection.delegate = self
        ofertasCollection.dataSource = self
        
        mejorCollection.delegate = self
        mejorCollection.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ofertasCollection {
            return 5
        }
        
        else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ofertasCollection {
            let ofertas = collectionView.dequeueReusableCell(withReuseIdentifier: "ofertascelda", for: indexPath) as! OfertasCell
            
            return ofertas
    
        }
        
        else{
            let mejores = collectionView.dequeueReusableCell(withReuseIdentifier: "mejorCelda", for: indexPath) as! MejoresCell
            
            return mejores
        }
        
    }
    
    func descargarDatos(){
        //Hacer aqui la peticion para descargar los datos
        
    }
}

