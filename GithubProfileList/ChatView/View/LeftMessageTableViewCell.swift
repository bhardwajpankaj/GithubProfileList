//
//  LeftMessageTableViewCell.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 22/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit

class LeftMessageTableViewCell: UITableViewCell,ReuseIdentifier ,NibLoadableView  {

    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    
    func changeImage(_ name: String, message:String) {
        messageLbl.text = message
        guard let image = UIImage(named: name) else { return }
        bubbleImageView.image = image.resizableImage(withCapInsets:UIEdgeInsetsMake(17, 21, 17,21),resizingMode: .stretch)
        self.layoutIfNeeded()
    }
    
}
