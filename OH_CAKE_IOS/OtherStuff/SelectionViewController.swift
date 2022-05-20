//
//  SelectionViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 17/5/22.
//

import UIKit
import FittedSheets

class SelectionViewController: UIViewController, UITabBarControllerDelegate {

    let def = UserDefaults.standard
    
    let options = SheetOptions(
        useInlineMode: true
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         if !def.bool(forKey: "logued"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
             
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "user") as! LogedUserViewController
            tabBarController?.present(vc, animated: true)
           
        }

    }
    
    
    
   
}
