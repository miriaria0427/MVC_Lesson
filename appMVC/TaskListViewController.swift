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

    var dataSource = TaskDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //dataSource = TaskDataSource()
        //dataSource.loadData()
    }
    
    //タスク登録画面から戻ってきたときに再描画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.reloadData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //配列tasksの内容を取得する
        let task = dataSource.data(at: indexPath.row)
        let dateFormatter = DateFormatter()
        // Date型→String型に変換
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: (task?.deadline)!)
        cell.textLabel?.text = task?.text
        cell.detailTextLabel?.text = deadlineText
        return cell
    }
}
