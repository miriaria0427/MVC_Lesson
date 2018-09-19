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
    
    //イニシャライザ　インスタンス生成時にUserDefaultsから最新の状態のデータを取得する
    override init(){
        let userDefaults = UserDefaults.standard
        let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String:Any]]
        guard let t = taskDictionaries else { return }
        
        print(#function)
        
        //辞書の要素から値を取り出す
        for dic in t{
            //値をTaskクラスの引数にセットして値を設定した後にTask配列に格納する
            let task = Task(from:dic)
            tasks.append(task)
        }
    }
    
    //配列の全要素を削除して最新のTask一覧を再取得するメソッド
    func reloadData(){
        //遷移先から遷移元に戻った時、生きてるTaskDataSourceインスタンスの配列tasksには初期表示のデータが格納されている状態
        //ゆえにデータの配列への二重取得を防ぐため配列の全要素を削除している
        tasks.removeAll()
        let userDefaults = UserDefaults.standard
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
        
        let userDefaults = UserDefaults.standard
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
    
    //デバッグ用
    override var debugDescription: String{
        return "tasks"
    }
}
