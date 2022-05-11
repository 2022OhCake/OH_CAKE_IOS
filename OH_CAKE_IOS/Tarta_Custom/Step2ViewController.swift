//
//  Step2ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 10/5/22.
//

import UIKit

class Step2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var size = ""
    var shape = ""
    
    @IBOutlet weak var formacollection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        formacollection.delegate = self
        formacollection.dataSource = self
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formacell", for: indexPath)
        
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
        
        let selectedCell:UICollectionViewCell = formacollection.cellForItem(at: indexPath)!
        shape = "kk"
              selectedCell.contentView.backgroundColor = hexStringToUIColor(hex: "#BEE2E0")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let cellToDeselect:UICollectionViewCell = formacollection.cellForItem(at: indexPath){
            cellToDeselect.contentView.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func step3Btn(_ sender: Any) {
        if shape == ""{
            let alert = UIAlertController(title: "Error", message: "¡No has elegido la forma!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "paso3") as! Step3ViewController
            
            vc.size = size
            vc.shape = shape
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
