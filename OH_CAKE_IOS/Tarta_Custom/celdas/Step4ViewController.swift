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
        
        if cell.isSelected {
            cell.contentView.backgroundColor = hexStringToUIColor(hex: "#BEE2E0")
        }
        else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Capturar aqui que boton ha pulsado
        
        let selectedCell:UICollectionViewCell = rellenoCollection.cellForItem(at: indexPath)!
        relleno = "kk"
              selectedCell.contentView.backgroundColor = hexStringToUIColor(hex: "#BEE2E0")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cellToDeselect:UICollectionViewCell = rellenoCollection.cellForItem(at: indexPath){
            cellToDeselect.contentView.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func ingredientesBtn(_ sender: Any) {
        
//        if relleno == ""{
//            let alert = UIAlertController(title: "Error", message: "¡No has elegido el relleno!", preferredStyle: .alert)
//
//            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
//
//            alert.addAction(action)
//
//            present(alert, animated: true, completion: nil)
//        }
//        else{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "paso4") as! Step4ViewController
//
//            vc.size = size
//            vc.shape = shape
//            vc.base = base
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
        print(relleno,base,shape,size)
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
