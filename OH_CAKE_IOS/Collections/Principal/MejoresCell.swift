//
//  MejoresCell.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 7/4/22.
//

import UIKit

class MejoresCell: UICollectionViewCell {
    
    
    @IBOutlet weak var foto_mejores: UIImageView!
    @IBAction func VerButton(_ sender: Any) {
    
        let Username =  "instagram" // Your Instagram Username here
            let appURL = URL(string: "instagram://user?username=(Username)")!
            let application = UIApplication.shared

        if application.canOpenURL(appURL){
                application.open(appURL)
        }
            else{
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/(Username)")!
                application.open(webURL)
            }
    }
    
}
