//
//  ViewController.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 11/11/2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //animation constants
    let tableCellHeight: CGFloat = 140
    let tableCellTranslationt: CGFloat = 60
    let animationDuration: TimeInterval = 1.5
    let animationDelay: TimeInterval = 0.07
    
    //scrooling up/down
    var tableViewScroolingUp = true
    var lastContentOffset: CGFloat = 0
    var lastCellAnimated = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.setCell(image: "mexico")
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
        self.lastCellAnimated = 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            //move up
            tableViewScroolingUp = true
        } else {
            //move down or stay
            tableViewScroolingUp = false
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        //just animate when scrolling up
        if(tableViewScroolingUp){
            cell.transform = CGAffineTransform(translationX: 0, y: self.tableCellTranslationt)
            UIView.animate(
                withDuration: self.animationDuration,
                delay: self.animationDelay * Double(self.lastCellAnimated),
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            
            self.lastCellAnimated = self.lastCellAnimated + 1
        }
    }
    
    
    
    
}

