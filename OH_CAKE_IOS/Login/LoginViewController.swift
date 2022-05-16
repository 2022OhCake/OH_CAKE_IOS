//
//  LoginViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 22/4/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    //Outlets de los campos de texto
    @IBOutlet weak var PassText: UITextField!
    @IBOutlet weak var UserText: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Esto esconde la barra cuando se instancia
        self.navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func EnviarButton(_ sender: Any) {
        
    //Si el campo usuario esta vacio
        if UserText.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Error, el campo usuario no puede estar vacio", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        //Si el campo contraseña esta vacio
        else if PassText.text!.isEmpty{
            let alert = UIAlertController(title: "Error", message: "Error, el campo contraseña no puede estar vacio", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        //Si el email es valido
        else if !isValidEmail(string: UserText.text!){
            let alert = UIAlertController(title: "Error", message: "¡Vaya!, Ese no parece un email valido", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        //Si la contraseña tiene la longitud adecuada
        else if PassText.text!.count < 6 {
            
            let alert = UIAlertController(title: "Error", message: "Error, el campo contraseña debe tener 6 caracteres como minimo", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else{
            //Si todas las condiciones se han cumplido hace la peticion
            self.login(user: UserText.text!, passwd: PassText.text!)

        }
    }
    
    func isValidEmail(string: String) -> Bool {
        //Funcion que comprueba con una expresion regular si el email es valido
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: string)
    }
    
    
    func login(user:String, passwd: String){
        //Url del servidor, si, esta en http pero es lo que hay
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/auth/login"
       
                       guard let url = URL(string: urlString) else {return}
       
                       var request = URLRequest(url: url)
       
                       request.httpMethod = "POST"
                    //Parametros del usuario
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
                               //Le paso el status code a la variable de arriba
                               code = res.statusCode
                           }
                           guard let datos = data else {return}
                            
                           do{
                               let json = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed)
                               
                               //Obtengo los datos del json
                               guard let newValue = json as? [String: Any] else {
                                                           print("invalid format")
                                                           return
                                                        }
                               
                               print(newValue)
                               
                               //Si el campo email no viene vacio quiere decir que hay un error
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
                                       //Si no hay ningun mensaje se procede al alert, los parametros son el status code y el mensaje(En este caso, esta abajo)
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
        //Esta funcion es para organizar las alertas por que si no se queda la peticion hecha una porqueria
        
        
        //Si el code es 422, Ha habido un error y alerta de ello(Esta validado arriba osea que si algo llega aqui quiere decir que ha petado por algun sitio)
        if code == 422 {
            
            let alert = UIAlertController(title: ":(", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        //El code 401 es unauthorized, quiere decir que los datos de login son incorrectos (Mal contraseña o mal usuario)
        else if code == 401{
            
            let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrecto", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        //Si el status code es 200, quiere decir que esta todo guay y que el login se ha hecho bien
        else if code == 200{
           
            let alert = UIAlertController(title: "Correcto", message: "Login realizado", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                
                //Selecciono la primera pantalla para que el tabbar me lleve a inicio
                self.tabBarController!.selectedIndex = 0
                
                //Pongo el bool de logueado a true
                self.defaults.set(true, forKey: "logued")
            })
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            
            //Si entra aqui es por que algo se ha muerto muy basto y a partir de aqui probablemente no es mi problema
            let alert = UIAlertController(title: "Error", message: "Error Desconocido", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
