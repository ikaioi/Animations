//
//  DetailsViewController.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 12/11/2021.
//

import UIKit

class DetailsViewController: UIViewController, AnimatedViewController{
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var textsView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(city != nil){
            backgroundImage.image = UIImage(named: city!.backgroundImage ?? "background")
            
            weatherImageView.image = UIImage(named: city!.seasonIcon ?? "summer")
            
            titleLabel.text = city!.name ?? ""
            subtitleLabel.text = city!.season ?? ""
            
            detailsTextView.text = city!.text ?? ""
        }
        
        bottomView.layer.cornerRadius = 20
        bottomView.layer.masksToBounds = true
        
        slideUpView()
    }
    
    //Just for example, I used a local slide animation in the view when ViewController loads
    //For popViewController, I keeped the transition animation in the bottomTextView
    func slideUpView() {
        bottomView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.size.height + 500)
        UIView.animate(
            withDuration: 2.0,
            delay: 0.5,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: [.curveEaseInOut],
            animations: {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
    func zoomingBackgroundView(for transition: TransitionDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: TransitionDelegate) -> UIImageView? {
        return backgroundImage
    }
    
    func zoomingTextsView(for transition: TransitionDelegate) -> UIView? {
        return textsView
    }
    
    func slidingTextView(for transition: TransitionDelegate) -> UIView? {
        return bottomView
    }
    
}

