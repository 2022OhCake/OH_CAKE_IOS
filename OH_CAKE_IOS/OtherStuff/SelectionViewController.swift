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
       
        let options = SheetOptions(
            useInlineMode: true
        )
        
        if !def.bool(forKey: "logued"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
            let sheetController = SheetViewController(controller: LogedUserViewController(), sizes: [.percent(0.3), .fullscreen], options: options)
            sheetController.allowGestureThroughOverlay = true

            // animate in
            sheetController.dismissOnPull = true
            sheetController.animateIn(to: view, in: self)
            
        }
    }
}
