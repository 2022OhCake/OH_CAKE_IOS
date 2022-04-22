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
            //Hacer aqui la peticion al servidor
        }
    }
    

}
