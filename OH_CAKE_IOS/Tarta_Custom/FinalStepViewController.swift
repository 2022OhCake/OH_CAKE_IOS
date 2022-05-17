//
//  FinalStepViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 16/5/22.
//

import UIKit

class FinalStepViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagepicker: UIImagePickerController = UIImagePickerController()
    lazy var imageview = UIImageView(frame: view.frame)

    //Aqui llega los datos de todo el proceso anterior
    var size = ""
    var shape = ""
    var base = ""
    var relleno = ""
    var ingredientes = "kk"
    
    
    @IBOutlet weak var foto_personalizada: UIImageView!
    @IBOutlet weak var dedicatoriaText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        
        imageview.contentMode = .scaleAspectFit
        view.addSubview(imageview)
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        present(imagepicker, animated: true)
    }
    
    @IBAction func LIstoBtn(_ sender: Any) {
        let alert = UIAlertController(title: "¡Genial!", message: "¡Pedido Realizado con Exito!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
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
                self.foto_personalizada.image = selectedImage
            }
        }
    
}
