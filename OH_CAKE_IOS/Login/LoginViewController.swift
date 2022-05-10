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

        }
    }
    
    
    func login(user:String, passwd: String){
        let urlString = "servidor.com/login/"
       
                       guard let url = URL(string: urlString) else {return}
       
                       var request = URLRequest(url: url)
       
                       request.httpMethod = "POST"
                   
                       let bodyData = "user=\(user)&password=\(passwd)&password_confirmation=\(passwd)"
        
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
                           
                           do{
                           let cosas = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed) as! String
                               
                               if cosas == "420"{
                                   //Instanciar la pantalla de login
                               }
                               
                               else{
                                   return
                               }
                           }
                           catch{
                               print("Error: \(error)")
                           }
       
                       }.resume()
    }
    

}
