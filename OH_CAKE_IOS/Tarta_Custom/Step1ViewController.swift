//
//  Step1ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 25/4/22.
//

import UIKit

class Step1ViewController: UIViewController {

    @IBOutlet weak var bigbtn: UIButton!
    @IBOutlet weak var mediumbtn: UIButton!
    @IBOutlet weak var smallbtn: UIButton!
    
    var size = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Small(_ sender: Any) {
        size = "Pequeña"
        smallbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        mediumbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
        bigbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
    }
    
    @IBAction func Medium(_ sender: Any) {
        size = "Mediana"
        smallbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
        mediumbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        bigbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
    }
    
    @IBAction func Big(_ sender: Any) {
        size = "Grande"
        smallbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
        mediumbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#FCF5F1")
        bigbtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
    }
    
    @IBAction func step2Btn(_ sender: Any){
        
        if size == ""{
            let alert = UIAlertController(title: "Error", message: "¡Necesitas decir el tamaño antes de continuar!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
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
