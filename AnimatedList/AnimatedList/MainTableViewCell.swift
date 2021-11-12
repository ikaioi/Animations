//
//  MainTableViewCell.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 11/11/2021.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    func setCell(image:String){
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        backgroundImageView.image = UIImage(named: image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
