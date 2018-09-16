//
//  TaskListViewController.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/13.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//

import Foundation
import UIKit

//コントローラー
 class TaskListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var dataSource = TaskDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //let dataSource = TaskDataSource()
        dataSource.loadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let dataSource = TaskDataSource()
        return dataSource.count()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let dataSource = TaskDataSource()
        let task = dataSource.data(at: indexPath.row)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: (task?.deadline)!)
        cell.textLabel?.text = task?.text
        cell.detailTextLabel?.text = deadlineText
        return cell
    }
}
