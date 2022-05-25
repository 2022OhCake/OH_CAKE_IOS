//
//  NotificationsCell.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 25/5/22.
//

import UIKit

class NotificationsCell: UITableViewCell {
    
    
    @IBOutlet weak var NumPedido: UILabel!
    @IBOutlet weak var tituloPedido: UILabel!
    @IBOutlet weak var FechaPedido: UILabel!
    @IBOutlet weak var foto_pedido: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
