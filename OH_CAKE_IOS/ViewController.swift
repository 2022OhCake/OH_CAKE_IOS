//
//  ViewController.swift
//  OH_CAKE_IOS
//
//  Created by Practica_libre on 16/3/22.
//

import UIKit
//Comprobar fittedSheets -> https://github.com/gordontucker/FittedSheets
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate{
   
    @IBOutlet weak var ofertasCollection: UICollectionView!
    @IBOutlet weak var mejorCollection: UICollectionView!
    
    @IBOutlet weak var UsuarioLabel: UILabel!
    let defaults = UserDefaults.standard

    @IBOutlet weak var registradoLabel: UILabel!
    @IBOutlet weak var crearcuentaBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.tabBarController?.delegate = self
        
        //Delegate de las ofertas
        ofertasCollection.delegate = self
        ofertasCollection.dataSource = self
        
        //Delegate de las ofertas 2
        mejorCollection.delegate = self
        mejorCollection.dataSource = self
 
        //self.defaults.set(true, forKey: "logued")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if defaults.bool(forKey: "logued") {
            registradoLabel.text = "Echa un vistazo a las categorias"
            crearcuentaBtn.setTitle("Categorias", for: .normal)
        }
        
        else{
            registradoLabel.text = "¿Todavía no estas registrado?"
            crearcuentaBtn.setTitle("Crear Cuenta", for: .normal)
           
        }
        
        let nombre = defaults.object(forKey: "usuario")
        let apellido = defaults.object(forKey: "apellido")
        
        if nombre != nil {
            UsuarioLabel.text = "Hola, \(nombre!)"
        }
        else{
            UsuarioLabel.text = "BIENVENIDO"
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
                 
        let newController = SelectionViewController()

        // Check if the view about to load is the second tab and if it is, load the modal form instead.
        if viewController == newController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "user")
            tabBarController.present(vc, animated: true, completion: nil)
            return false
        } else {
            return true
        }
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
        
        if defaults.bool(forKey: "logued") {
            self.tabBarController?.selectedIndex = 1
        }
        
        else{
            self.tabBarController!.selectedIndex = 4
        }
        
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
}

extension UIImageView {

    //Esta funcion es para redondear la foto de perfil
    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = hexStringToUIColor(hex: "#5B300D").cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = self.frame.height / 2
        assert(bounds.height == bounds.width, "The aspect ratio isn't 1/1. You can never round this image view!")
        self.clipsToBounds = true
    }
    
    //Esta esta declarada en mas sitios pero sirve para pasar un string de color hexadecimal a UICOLOR
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
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

}


