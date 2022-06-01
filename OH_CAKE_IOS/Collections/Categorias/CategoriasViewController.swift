//
//  CategoriasViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 6/5/22.
//

import UIKit

class CategoriasViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var categorias:[[String:Any]] = [[:]]
    
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var categoriascollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriascollection.delegate = self
        categoriascollection.dataSource = self
        
        self.getcategorias()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdaCategorias", for: indexPath) as! CategoriasCell
        
        if !categorias[indexPath.row].isEmpty{
            cell.CategoriaLabel.text = categorias[indexPath.row]["name_category"] as? String
            
            let urlString = categorias[indexPath.row]["image"] as! String
            guard let url = URL(string: urlString) else {return cell}
            cell.fotoCategoria.load(url: url)
            print(categorias[indexPath.item]["name_category"]!)
            
            
        }
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tartascontroller") as! TartasViewController
        
        vc.id_categoria = categorias[indexPath.item]["id"] as! Int
        vc.nombreCat = (categorias[indexPath.row]["name_category"] as? String)!

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
                let cosas = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed) as! [[String:Any]]
     
                self.categorias = cosas
                print(cosas)
         
                DispatchQueue.main.async {
                    self.categoriascollection.reloadData()
                    self.LoadingView.isHidden = true
                }
                
            }
            catch{
                print("Error: \(error)")
            }

        }.resume()
        
        
    }
    
    
    

}
