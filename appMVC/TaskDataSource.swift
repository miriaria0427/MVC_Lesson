//
//  TaskDataSource.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/12.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//


import Foundation

//モデルクラス　データに関するロジック
class TaskDataSource:NSObject{
    
    //task について
    //Task 一覧を保持するArray UITableViewに表示させるためのデータ
    private var tasks = [Task]()
    //ユーザデフォルトを保持
    let userDefaults = UserDefaults.standard
    
    //UserDefaultsから保存したTask一覧を取得するメソッド
    func loadData(){
        let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String:Any]]
        guard let t = taskDictionaries else { return }
        
        //辞書の要素から値を取り出す
        for dic in t{
            //値をTaskクラスの引数にセットして値を設定した後にTask配列に格納する
            let task = Task(from:dic)
            tasks.append(task)
        }
    }
    
    //TaskをUserDefaultsに保存するメソッド
    func save(task:Task){
        tasks.append(task)
        
        var taskDictionaries = [[String:Any]]()
        for t in tasks{
            let taskDictionary:[String:Any] = ["text": t.text, "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }
        
        //let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries,forKey:"tasks")
        userDefaults.synchronize()
    }
    
    //配列tasksのカウントを返すメソッド
    func count() ->Int{
        return tasks.count
    }
    
    //配列tasksの内容を返すメソッド
    func data(at index: Int)->Task?{
        if tasks.count > index{
            return tasks[index]
        }
        return nil
    }
    
    
}
