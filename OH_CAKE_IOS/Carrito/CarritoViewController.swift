//
//  CarritoViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 3/6/22.
//

import UIKit

class CarritoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var SubtotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var ProductosTableView: UITableView!
    
    var currentSubtotal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProductosTableView.delegate = self
        self.ProductosTableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrito.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "producto", for: indexPath) as! ProductoCell
    
        
        if carrito.count > 1 {
            cell.Nombre_Producto_Label.text = carrito[indexPath.item]["nombre"] as? String
            cell.Precio_Producto_label.text = carrito[indexPath.item]["precio"] as? String
            
            let urlString = carrito[indexPath.item]["image"] as? String
            
            if urlString != nil{
                guard let url = URL(string: urlString!) else {return cell}
                
                cell.foto_producto.load(url: url)
            }
            
            /// TO DO : Arreglar por aqui el tema de la cantidad
            guard let numStr = carrito[indexPath.item]["precio"] as? String else {
                return cell
            }
            
            let precio = Double(numStr)
            
            let subt = precio! * Double(cell.currentUnidades)
            
            print(subt)
            
            SubtotalLabel.text = "\(currentSubtotal + subt) €"
        }
        return cell
    }

    @IBAction func FinalizarBtn(_ sender: Any) {
        
    }
    

}
