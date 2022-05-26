//
//  PedidosViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 26/5/22.
//

import UIKit

class PedidosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var pedidosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pedidosTableView.delegate = self
        self.pedidosTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pedidoscell", for: indexPath) as! PedidosCell
        
        return cell
    }
    

}
