//
//  Step4ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Practica_libre on 11/5/22.
//

import UIKit

class Step4ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var rellenoCollection: UICollectionView!
    
    var size = ""
    var shape = ""
    var base = ""
    var relleno = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rellenoCollection.delegate = self
        rellenoCollection.dataSource = self
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdarelleno", for: indexPath)
        
        
        return cell
    }

    
}
