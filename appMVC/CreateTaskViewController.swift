//
//  CreateTaskViewController.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/13.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//

import Foundation
import UIKit

 //コントローラー
  class CreateTaskViewController: UIViewController {
    
    private var createTaskView: CreateTaskView!
    private var dataSource: TaskDataSource!
    
    private var taskText: String?
    private var taskDeadline: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
    }
    
    // 保存が成功した時のアラート
    private func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力の時のアラート
    private func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // 締切日が未入力の時のアラート
    private func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditting view: CreateTaskView, text: String) {
        taskText = text
    }
    
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        taskDeadline = deadline
    }
    
    func createView(saveButtonDidTap view: CreateTaskView) {
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
}
