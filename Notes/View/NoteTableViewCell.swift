//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Victor Peralta on 23/09/23.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet var titleNote: UILabel!
    
    
    @IBOutlet var detailNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
