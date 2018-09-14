//
//  CreateTaskView.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/13.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//

import Foundation
import UIKit

//View
protocol CreateTaskViewDelegate: class {
    func createView(taskEditting view: CreateTaskView, text: String)
    func createView(deadlineEditting view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}

 class CreateTaskView: UIView {
    
      private var deadlineTextField: UITextField! // 締切時間を入力するUITextField
    
    private var datePicker: UIDatePicker! // 締切時間を表示するUIPickerView
    
    
    weak var delegate: CreateTaskViewDelegate?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        // UITextFieldが編集モードになった時に、キーボードではなく、UIDatePickerになるようにしている
        deadlineTextField.inputView = datePicker
        
    }
    
    //ストーリボードを使う場合は呼ばれない
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        deadlineTextField.text = deadlineText
        delegate?.createView(deadlineEditting: self, deadline: sender.date)
    }
}

extension CreateTaskView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            delegate?.createView(taskEditting: self, text: textField.text ?? "")
        }
        return true
    }
}
