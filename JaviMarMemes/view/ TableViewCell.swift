//
//   TableViewCell.swift
//  JaviMarMemes
//
//  Created by Javi on 10/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell
{    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeCellTextLabel: UILabel!
    
    func setMemeTableItem(memeItem: Meme)
    {
        memeImageView.image = memeItem.memedImage
        memeCellTextLabel.text = "\(String(describing: memeItem.topTextField)) ... \(String(describing: memeItem.bottomTextField))"
    }
}
