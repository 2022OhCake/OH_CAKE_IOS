//
//  TABBARViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 17/5/22.
//

import UIKit
import FittedSheets

class TABBARViewController: UITabBarController, UITabBarControllerDelegate{

   
    let standards = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        tabBarController?.delegate = self
        
        // Do any additional setup after loading the view.
        
        self.tabBar.items![4].title = "Usuario"
        self.tabBar.items![3].title = "Mapa"
        self.tabBar.items![2].title = ""
        self.tabBar.items![1].title = "Categorias"
        self.tabBar.items![0].title = "Inicio"
        
    }
   
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if tabBar.selectedItem?.title == "Usuario"{
//            if !standards.bool(forKey: "logued"){
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            else{
//
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//                let vc = storyboard.instantiateViewController(withIdentifier: "user") as! LogedUserViewController
//
//                self.present(vc, animated: true, completion: nil)
//
//            }
//        }
    }
    
   
}
