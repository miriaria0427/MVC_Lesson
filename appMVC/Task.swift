//
//  Task.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/12.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//

import Foundation

//モデルクラス モデル定義
class Task{
    
    let text :String
    let deadline:Date
    
    init(text: String,deadline: Date){
        self.text = text
        self.deadline = deadline
    }
    
    init(from dictionary:[String: Any]){
        self.text = dictionary["text"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
}
