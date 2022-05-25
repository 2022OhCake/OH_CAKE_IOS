//
//  NotificationsViewController.swift
//  OH_CAKE_IOS
//
//  Created by Jose Manuel Qastusoft on 25/5/22.
//

import UIKit

class NotificationsViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var notificationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationscell", for: indexPath) as! NotificationsCell
        
        return cell
    }

}
