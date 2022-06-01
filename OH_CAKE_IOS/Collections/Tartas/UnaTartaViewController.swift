//
//  UnaTartaViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 31/5/22.
//

import UIKit

class UnaTartaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var IngredientesTable: UITableView!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var foto_tarta: UIImageView!
    @IBOutlet weak var NombreTartaLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    
    var detalles:[String:Any] = [:]
    var ingredientes:[[String:Any]] = [[:]]
    
    var id_tarta = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.IngredientesTable.delegate = self
        self.IngredientesTable.dataSource = self
        
        self.getTarta()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientes", for: indexPath) as! TartaCell
        
        if ingredientes.count > 1{
            cell.IngredienteLabel.text = ingredientes[indexPath.item]["name"] as! String
        }
        
        return  cell
    }
   
    @IBAction func CarritoBtn(_ sender: Any) {
    }
    
    @IBAction func ComprarBtn(_ sender: Any) {
    }
    
    func getTarta(){
        
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/defaultcakeingredient/\(id_tarta)"
        
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
                let cosas = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed) as! [String:Any]
                
                self.detalles = cosas
                self.ingredientes = cosas["ingredients"] as! [[String : Any]]
                
                print(cosas)
                
                DispatchQueue.main.async {
                    self.IngredientesTable.reloadData()
                    let string = cosas["image"] as! String
                    guard let url = URL(string: string) else {return}
                    self.foto_tarta.load(url: url)
                    self.NombreTartaLabel.text = cosas["name"] as! String
                    self.DescriptionLabel.text = cosas["description"] as! String
                    self.precioLabel.text = "\(cosas["cost"] as! String) €"
                }
                
            }
            catch{
                print("Error: \(error)")
            }

        }.resume()
    }
    
    
}
