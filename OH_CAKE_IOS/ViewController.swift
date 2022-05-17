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
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate de las ofertas
        ofertasCollection.delegate = self
        ofertasCollection.dataSource = self
        
        //Delegate de las ofertas 2
        mejorCollection.delegate = self
        mejorCollection.dataSource = self
        
        self.defaults.set(true, forKey: "logued")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ofertasCollection {
            return 5
        }
        
        else{
            return 10
        }
    }
    @IBAction func AccountBtn(_ sender: Any) {
        self.tabBarController!.selectedIndex = 4
    }
    
    @IBAction func PedirBtn(_ sender: Any) {
        self.tabBarController!.selectedIndex = 1
    }
    
    @IBAction func CustomBtn(_ sender: Any) {
        self.tabBarController!.selectedIndex = 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Si el collection view que recibe es el de las ofertas, instancia la celda correspondiente
        if collectionView == ofertasCollection {
            
            let ofertas = collectionView.dequeueReusableCell(withReuseIdentifier: "ofertascelda", for: indexPath) as! OfertasCell
            
            return ofertas
        }
        
        else{
            
            //Si no, instancia la otra
            let mejores = collectionView.dequeueReusableCell(withReuseIdentifier: "mejorCelda", for: indexPath) as! MejoresCell
            
            return mejores
        }
        
    }
    
    func descargarDatos(){
        //Hacer aqui la peticion para descargar los datos
        
    }
}

