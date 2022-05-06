//
//  RegistroViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 25/4/22.
//

import UIKit

class RegistroViewController: UIViewController {

    
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var ApellidosText: UITextField!
    @IBOutlet weak var telefonoText: UITextField!
    
    @IBOutlet weak var OtroBtn: UIButton!
    @IBOutlet weak var MujerBtn: UIButton!
    @IBOutlet weak var HombreBtn: UIButton!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var PasswdText: UITextField!
    @IBOutlet weak var RepeatPasswdText: UITextField!
    
    var sexo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registroBtn(_ sender: Any) {
        
        if nombreText.text!.isEmpty || ApellidosText.text!.isEmpty || telefonoText.text!.isEmpty || emailText.text!.isEmpty || PasswdText.text!.isEmpty || RepeatPasswdText.text!.isEmpty {
            
            let alert = UIAlertController(title: "Error", message: "Error, completa todos los campos antes de continuar", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else if RepeatPasswdText.text != PasswdText.text{
            let alert = UIAlertController(title: "Error", message: "Error, las contraseñas no coinciden", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else if sexo == ""{
            let alert = UIAlertController(title: "Error", message: "Por favor, especifica tu sexo, si prefieres no especificar, selecciona otro", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        else{
            registrar(nombre: nombreText.text!, apellidos: ApellidosText.text!, telefono: telefonoText.text!, email: emailText.text!, passwd: PasswdText.text!, sexo: sexo)
        }
       
    }
    
    func registrar(nombre: String, apellidos: String, telefono:String, email: String, passwd:String, sexo:String){
        
        //TO DO - Hacer peticion
        let urlString = "servidor.com/registro/"
       
                       guard let url = URL(string: urlString) else {return}
       
                       var request = URLRequest(url: url)
       
                       request.httpMethod = "POST"
                   
                       let bodyData = "first_name=\(nombre)&last_name=\(apellidos)&email=\(email)&telephone=\(telefono)&gender=\(sexo)&password=\(passwd)"
        
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
                               
                               if cosas == "420" {
                                   //Instancia pantalla login
                               }
                               
                           }
                           catch{
                               print("Error: \(error )")
                           }
                           
                       }.resume()
    }
    
    @IBAction func ManBtn(_ sender: Any) {
        sexo = "Hombre"
        HombreBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#EBD3DA")
        MujerBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        OtroBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        
        //EBD3DA rosa
        //77CBCC azul
    }
    
    @IBAction func WomanBtn(_ sender: Any) {
        sexo = "Mujer"
        HombreBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        MujerBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#EBD3DA")
        OtroBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
    }
    
    @IBAction func OtherBtn(_ sender: Any) {
        sexo = "Otro"
        HombreBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        MujerBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#77CBCC")
        OtroBtn.configuration?.background.backgroundColor = hexStringToUIColor(hex: "#EBD3DA")
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
