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
    
    @IBAction func logout(_ sender: Any) {
        
        
        
        let alert = UIAlertController(title: "¡Atencion!", message: "¿Seguro que quieres cerrar tu sesion?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
            self.dismiss(animated: true)
            self.defaults.set(false, forKey: "logued")
            self.tabBarController?.selectedIndex = 0
        })
        
        alert.addAction(action)
        
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
    

}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = self.frame.width / 2
        assert(bounds.height == bounds.width, "The aspect ratio isn't 1/1. You can never round this image view!")
        self.clipsToBounds = true
    }
}
