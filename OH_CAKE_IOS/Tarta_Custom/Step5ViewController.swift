//
//  Step5ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 12/5/22.
//

import UIKit

class Step5ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var size = ""
    var shape = ""
    var base = ""
    var relleno = ""
    var ingredientes = "kk"
    @IBOutlet weak var IngredientesCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        IngredientesCollection.delegate = self
        IngredientesCollection.dataSource = self
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaIngrediente", for: indexPath)
        
        if cell.isSelected {
            cell.contentView.backgroundColor = hexStringToUIColor(hex: "#BEE2E0")
        }
        else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }

    @IBAction func FinalStepBtn(_ sender: Any) {
        if ingredientes == ""{
            let alert = UIAlertController(title: "Error", message: "¡No has elegido la Base!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "paso5") as! Step5ViewController
            
            vc.size = size
            vc.shape = shape
            vc.base = base
            vc.relleno = relleno
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
