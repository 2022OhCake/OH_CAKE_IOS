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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
        
        else if !isValidEmail(string: UserText.text!){
            let alert = UIAlertController(title: "Error", message: "¡Vaya!, Ese no parece un email valido", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        
        else if PassText.text!.count < 6 {
            
            let alert = UIAlertController(title: "Error", message: "Error, el campo contraseña debe tener 6 caracteres como minimo", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else{
            
            self.login(user: UserText.text!, passwd: PassText.text!)

        }
    }
    
    func isValidEmail(string: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    
    func login(user:String, passwd: String){
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/auth/login"
       
                       guard let url = URL(string: urlString) else {return}
       
                       var request = URLRequest(url: url)
       
                       request.httpMethod = "POST"
                   
                       let bodyData = "email=\(user)&password=\(passwd)&password_confirmation=\(passwd)"
        
                       request.setValue(String(bodyData.lengthOfBytes(using: .utf8)), forHTTPHeaderField: "Content-Length")
        
                       request.httpBody = bodyData.data(using: String.Encoding.utf8)
       
                       URLSession.shared.dataTask(with: request){(data,response,error) in

                           var code = 0
                           
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
                               code = res.statusCode
                           }
                           guard let datos = data else {return}
                               
//                               let str = String(decoding: datos, as: UTF8.self)
//                               print(str)
                           do{
                               let json = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed)
                               
                               guard let newValue = json as? [String: Any] else {
                                                           print("invalid format")
                                                           return
                                                        }
                               
                               print(newValue)
                               
                               if !(newValue["email"] == nil){
                                
                                   let texto = String(describing: newValue["email"]!)
                                   
                                   let a = texto.replacingOccurrences(of: "(", with: "")
                                   let o = a.replacingOccurrences(of: ")", with: "")
                                   
                                   DispatchQueue.main.async {
                                       self.alertas(code: code, message: o)
                                    }
                               }
                               
                               else{
                                   DispatchQueue.main.async {
                                       self.alertas(code: code, message: "")
                                    }
                               }
                               
                           
                           }
                           catch let jsonError{
                              // print("Error: \(jsonError)")
                           }
 
                       }.resume()
    }
    

    func alertas(code:Int, message: String){
        
        
        if code == 422 {
            
            let alert = UIAlertController(title: ":(", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if code == 401{
            
            let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecto", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if code == 200{
            //Instanciar pantalla usuario
            let alert = UIAlertController(title: "Correcto", message: "Login realizado", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            let alert = UIAlertController(title: "Error", message: "Error Desconocido", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
