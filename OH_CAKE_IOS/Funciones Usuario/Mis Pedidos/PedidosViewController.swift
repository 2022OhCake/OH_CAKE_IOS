//
//  PedidosViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 26/5/22.
//

import UIKit

class PedidosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var pedidosTableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var Loadingview: UIView!
    var pedidos:[[String:Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pedidos[0].isEmpty{
            pedidos.remove(at: 0)
        }

        self.pedidosTableView.delegate = self
        self.pedidosTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.getPedidos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pedidoscell", for: indexPath) as! PedidosCell
        
        if pedidos.count > 1 {
            let id = "\(pedidos[indexPath.item]["id"] as! Int)"
            cell.Num_Pedido_Label.text = id
            cell.Estado_Pedido_Label.text = pedidos[indexPath.item]["status"] as! String
            
            if pedidos[indexPath.item]["created_at"] != nil{
                //cell.Fecha_Pedido_Label.text = pedidos[indexPath.item]["created_at"] as! String
            }
            else{
                cell.Fecha_Pedido_Label.text = "Desconocido"
            }
           
            //cell.Descripcion_Pedido_Label.text = pedidos[indexPath.item][""] as! String
        }
        
        
        
        return cell
    }
    
    
    func getPedidos(){
        let urlString = "http://rumpusroom.es/tfc/back_cake_api_panels/public/api/orderdefaultcake/6"
        
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
                
                print(cosas)
                
                self.pedidos = cosas
                
                DispatchQueue.main.async {
                    self.pedidosTableView.reloadData()
                    self.Loadingview.isHidden = true
                }
                    
                }
            
            catch{
                print("Error: \(error)")
            }

        }.resume()
    }

}
