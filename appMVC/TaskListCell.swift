//
//  TaskListCell.swift
//  appMVC
//
//  Created by mayuka.kawamukai on 2018/09/13.
//  Copyright © 2018年 mayuka.kawamukai. All rights reserved.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    
    //View
    
    private var taskLabel: UILabel!
    private var deadlineLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        taskLabel = UILabel()
        taskLabel.textColor = UIColor.black
        taskLabel.font = UIFont.systemFont(ofSize:14)
        contentView.addSubview(taskLabel)
        
        deadlineLabel = UILabel()
        deadlineLabel.textColor = UIColor.black
        deadlineLabel.font = UIFont.systemFont(ofSize:14)
        contentView.addSubview(deadlineLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
        
        taskLabel.frame = CGRect(x: 15.0, y: 15.0, width:contentView.frame.width - (15.0*2), height: 15)
    }
    
    var task:Task?{
        didSet{
            guard let t = task else{return}
            taskLabel.text = t.text
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            deadlineLabel.text = formatter.string(from: t.deadline)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
