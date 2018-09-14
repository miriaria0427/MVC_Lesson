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
    
    private var dataSource: TaskDataSource!
    private var datePicker: UIDatePicker!
    
    @IBOutlet weak var taskText: UITextField!
    
    @IBOutlet weak var taskDeadline: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        // UITextFieldが編集モードになった時に、キーボードではなく、UIDatePickerになるようにしている
        taskDeadline.inputView = datePicker
        
        dataSource = TaskDataSource()
    }
    
    //保存ボタンタップ時の挙動
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskText = taskText.text else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline.text else {
            showMissingTaskDeadlineAlert()
            return
        }
        
        //タスク、締切日時が両方入力されていたら保存
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.date(from: taskDeadline)
        let task = Task(text: taskText, deadline: deadlineText!)
        dataSource.save(task: task)
        
        showSaveAlert()
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
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        taskDeadline.text = deadlineText
    }
}
