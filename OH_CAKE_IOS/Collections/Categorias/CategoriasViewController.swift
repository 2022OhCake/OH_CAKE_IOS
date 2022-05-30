//
//  CategoriasViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 6/5/22.
//

import UIKit

class CategoriasViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let categorias = [""]
    
    @IBOutlet weak var categoriascollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriascollection.delegate = self
        categoriascollection.dataSource = self
        
        self.getcategorias()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaCategorias", for: indexPath) as! CategoriasCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tartascontroller") as! TartasViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getcategorias(){
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/cakecategory"
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
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
                let cosas = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed)
                print(cosas)
            }
            catch{
                print("Error: \(error)")
            }

        }.resume()
        
        
    }
    
    
    

}
