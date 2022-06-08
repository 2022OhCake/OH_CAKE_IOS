//
//  FinalStepViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 16/5/22.
//

import UIKit
import Alamofire
class FinalStepViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagepicker: UIImagePickerController = UIImagePickerController()
    lazy var imageview = UIImageView(frame: view.frame)
    let defaults = UserDefaults.standard
    //Aqui llega los datos de todo el proceso anterior
    var size = ""
    var shape = ""
    var base = ""
    var relleno = ""
    var ingredientes:[[String:Int]] = [[:]]
    
    
    @IBOutlet weak var foto_personalizada: UIImageView!
    @IBOutlet weak var dedicatoriaText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
              view.addGestureRecognizer(tapGesture)
        
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        
        imageview.contentMode = .scaleAspectFit
        view.addSubview(imageview)
    }
    
    @objc func tapGestureHandler() {
        dedicatoriaText.endEditing(true)
      }
    
    @IBAction func pickImage(_ sender: Any) {
        present(imagepicker, animated: true)
    }
    
    @IBAction func LIstoBtn(_ sender: Any) {
        
//        let alert = UIAlertController(title: "¡Genial!", message: "¡Pedido Realizado con Exito!", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)]
        
        self.PedirTartaCustom(Size: size, Shape: shape, Base: base, Relleno: relleno, Ingredients: ingredientes, Dedicatoria: dedicatoriaText.text, Image: foto_personalizada)
        
    }
    
    func PedirTartaCustom(Size:String, Shape:String, Base:String, Relleno:String, Ingredients:[[String:Int]], Dedicatoria:String?, Image:UIImageView?){
        
        let datas = try! JSONSerialization.data(withJSONObject: Ingredients, options: JSONSerialization.WritingOptions.prettyPrinted)
        let ingredi = NSString(data: datas, encoding: String.Encoding.utf8.rawValue)
        
        let id = defaults.object(forKey: "usuario_id")
        
        let json = "{'user_id':\(id),'products':{}"
        
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/order"
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
//        
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let data = try! JSONSerialization.data(withJSONObject: parametros, options: JSONSerialization.WritingOptions.prettyPrinted)
//        
//        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//        if let json = json{
//            print(json)
//        }
//        
//        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
//        let alamoRequest = AF.request(request as URLRequestConvertible)
//        alamoRequest.validate(statusCode: 200..<300)
//        alamoRequest.responseString { response in
//            
//            print(response.result)
//            
//        // Pagina aleatoria que igual me ayuda yo que se https://ajaxhispano.com/ask/como-enviar-una-solicitud-post-con-body-en-swift-40386/
//            
//        }
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
