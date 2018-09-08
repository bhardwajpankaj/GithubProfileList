//
//  UserTableViewCell.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 21/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell, ReuseIdentifier ,NibLoadableView{
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var sessionTask : URLSessionTask?
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
    }
    
    func updateInterface(title:String?){
        userLabel.text = "@\(title ?? "")"
    }
}
