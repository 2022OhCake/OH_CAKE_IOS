//
//  TartasViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 26/5/22.
//

import UIKit

class TartasViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var TartasCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.TartasCollection.delegate = self
        self.TartasCollection.dataSource = self
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tartascell", for: indexPath) as! TartasCell
    
        return cell
    }

}
