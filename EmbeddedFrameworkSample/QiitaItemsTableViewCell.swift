//
//  QiitaItemsTableViewCell.swift
//  EmbeddedFrameworkSample
//
//  Created by iniad on 2019/04/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import Domain
import SnapKit

class QiitaItemsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(item: Item) {
        
    }

}
