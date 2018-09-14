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
 class TaskListViewController: UIViewController {
    
    private var dataSource: TaskDataSource!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dataSource = TaskDataSource()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(barButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.loadData()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: view.safeAreaInsets.left,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height - view.safeAreaInsets.bottom)
    }
    
    @objc func barButtonTapped(sender: UIBarButtonItem) {
        let controller = CreateTaskViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskListCell
        cell.task = dataSource.data(at: indexPath.row)
        return cell
    }
}
