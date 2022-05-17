//
//  SelectionViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 17/5/22.
//

import UIKit
import FittedSheets

class SelectionViewController: UIViewController {

    let def = UserDefaults.standard
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controllerUser = LogedUserViewController()
        let options = SheetOptions(
            useInlineMode: true
        )
        
        if !def.bool(forKey: "logued"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
            let sheetController = SheetViewController(controller: controllerUser.self, sizes: [.percent(0.3), .fullscreen], options: options)
            sheetController.allowGestureThroughOverlay = true

            // animate in
            sheetController.dismissOnPull = true
            sheetController.animateIn(to: view, in: self)
            
        }
    }
    

    

}
