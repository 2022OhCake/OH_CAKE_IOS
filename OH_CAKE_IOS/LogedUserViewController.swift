//
//  LogedUserViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 17/5/22.
//

import UIKit

class LogedUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let defaults = UserDefaults.standard
    var imagepicker: UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var foto_perfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foto_perfil.makeRounded()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func changeProfilepic(_ sender: Any) {
        present(imagepicker, animated: true)
    }
    
    @IBAction func ContactoBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "contacto") as! ContactoViewController
        self.present(vc, animated: true)
    }
    @IBAction func logout(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "¡Atencion!", message: "¿Seguro que quieres cerrar tu sesion?", preferredStyle: .alert)
        
        let confirmar = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
            self.dismiss(animated: true)
            self.defaults.set(false, forKey: "logued")
            self.tabBarController?.selectedIndex = 0
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alert.addAction(confirmar)
        alert.addAction(cancelar)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            /// 5. Este método se activa cuando el usuario selecciona una imagen y devuelve información sobre la imagen seleccionada.
            /// 6. Obtenga el atributo originImage en esta imagen, que es la imagen misma
            guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                fatalError("error: did not picked a photo")
            }
            /// 7. Realice otras operaciones relacionadas según sea necesario, seleccione la imagen aquí y luego cierre el controlador del selector
            picker.dismiss(animated: true) { [unowned self] in
                // add a image view on self.view
                self.foto_perfil.image = selectedImage
            }
        }
//5B300D

}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = hexStringToUIColor(hex: "#5B300D").cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = self.frame.height / 2
        //assert(bounds.height == bounds.width, "The aspect ratio isn't 1/1. You can never round this image view!")
        self.clipsToBounds = true
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
