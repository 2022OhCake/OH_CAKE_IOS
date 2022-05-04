//
//  LoginViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 22/4/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var PassText: UITextField!
    @IBOutlet weak var UserText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func EnviarButton(_ sender: Any) {
        
        if UserText.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Error, el campo usuario no puede estar vacio", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else if PassText.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Error, el campo contraseña no puede estar vacio", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else{
            
            self.login(user: UserText.text!, passwd: PassText.text!)
            
            //Hacer aqui la peticion al servidor
            
//            func sellarPetition(clave: String){
//
//                let urlString = "\(constantes.servidor)/\(constantes.year)/App/sellarIos2016/"
//
//                guard let url = URL(string: urlString) else {return}
//
//                var request = URLRequest(url: url)
//
//                request.httpMethod = "POST"
//
//                //La clase UIDevice.current saca la id del dispositivo
//                let id = UIDevice.current.identifierForVendor?.uuidString
//
//
//                let cosasParaPasar = "\(id!),\(tapa.id),\(clave)"
//                print(": \(cosasParaPasar)")
//                let bodyData = "v=\(cosasParaPasar)"
//                request.setValue(String(bodyData.lengthOfBytes(using: .utf8)), forHTTPHeaderField: "Content-Length")
//                request.httpBody = bodyData.data(using: String.Encoding.utf8)
//
//                URLSession.shared.dataTask(with: request){(data,response,error) in
//
//
//                    //Si el error no es nulo que nos diga que está pasando
//                    if error != nil {
//                        print ("Error: \(error!.localizedDescription)")
//                    }
//                    //Si la respuesta es nula,que nos digo que no hay respuesta
//                    if response != nil {
//                        print (response ?? "No se ha obtenido respuesta")
//                    }
//                    if let res = response as? HTTPURLResponse {
//                        print("Status code: \(res.statusCode)")
//                    }
//                    guard let datos = data else {return}
//
//                        let str = String(decoding: datos, as: UTF8.self)
//                        print(str)
//
//                    DispatchQueue.main.async { [self] in
//                        self.sellado(Mensaje: str)
//                    }
//
//
//                }.resume()
//            }
        }
    }
    
    
    func login(user:String, passwd: String){
        let urlString = "servidor.com/login/"
       
                       guard let url = URL(string: urlString) else {return}
       
                       var request = URLRequest(url: url)
       
                       request.httpMethod = "POST"

                       let cosasParaPasar = ""
                   
                       let bodyData = "user=\(cosasParaPasar)"
        
                       request.setValue(String(bodyData.lengthOfBytes(using: .utf8)), forHTTPHeaderField: "Content-Length")
        
                       request.httpBody = bodyData.data(using: String.Encoding.utf8)
       
                       URLSession.shared.dataTask(with: request){(data,response,error) in

                           //Si el error no es nulo que nos diga que está pasando
                           if error != nil {
                               print ("Error: \(error!.localizedDescription)")
                           }
                           //Si la respuesta es nula,que nos digo que no hay respuesta
                           if response != nil {
                               print (response ?? "No se ha obtenido respuesta")
                           }
                           if let res = response as? HTTPURLResponse {
                               print("Status code: \(res.statusCode)")
                           }
                           guard let datos = data else {return}
       
                               let str = String(decoding: datos, as: UTF8.self)
                               print(str)
       
                       }.resume()
    }
    

}
