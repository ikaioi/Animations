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
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var textsView: UIView!
    
    
    func setCell(city:City){
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        backgroundImageView.image = UIImage(named: city.backgroundImage ?? "background")
        
        weatherImageView.image = UIImage(named: city.seasonIcon ?? "summer")
        
        titleLabel.text = city.name ?? ""
        subtitleLabel.text = city.season ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
