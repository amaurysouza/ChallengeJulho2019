//
//  ValorCell.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 30/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit

class ValorCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let valueCellBg = UIColor(red: 93/255, green: 149/255, blue: 255/255, alpha: 1)
        backgroundColor = valueCellBg
        
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
