//
//  BaseTableViewCell.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 17.07.2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    
    static var reuseId: String {
        String(describing: self.self)
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
