//
//  ViewController.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 11/11/2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnimatedViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //animation constants
    let tableCellHeight: CGFloat = 200
    let tableCellTranslationt: CGFloat = 60
    let animationDuration: TimeInterval = 1.5
    let animationDelay: TimeInterval = 0.07
    
    //scrooling up/down
    var tableViewScroolingUp = true
    var lastContentOffset: CGFloat = 0
    var lastCellAnimated = 1
    
    var cities : [City] = []
    
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMockData()
    }
    
    
    func initMockData(){
        let mexico = City(name: "Mexico City", season: "Spring", seasonIcon: "spring", backgroundImage: "mexico", text: getMockText())
        let beijing = City(name: "Beijing", season: "Spring", seasonIcon: "spring", backgroundImage: "beijing", text: getMockText())
        let newdelhi = City(name: "New Delhi", season: "Summer", seasonIcon: "summer", backgroundImage: "newdelhi", text: getMockText())
        let capetown = City(name: "Cape Town", season: "Spring", seasonIcon: "spring", backgroundImage: "capetown", text: getMockText())
        let cairo = City(name: "Cairo", season: "Summer", seasonIcon: "summer", backgroundImage: "cairo", text: getMockText())
        let istanbul = City(name: "Istanbul", season: "Spring", seasonIcon: "spring", backgroundImage: "istanbul", text: getMockText())
        let moscow = City(name: "Moscow", season: "Summer", seasonIcon: "summer", backgroundImage: "moscow", text: getMockText())
        let sydney = City(name: "Sydney", season: "Summer", seasonIcon: "summer", backgroundImage: "sydney", text: getMockText())
        let newyork = City(name: "New York", season: "Spring", seasonIcon: "spring", backgroundImage: "newyork", text: getMockText())
        let paris = City(name: "Paris", season: "Spring", seasonIcon: "spring", backgroundImage: "paris", text: getMockText())
        let tokyo = City(name: "Tokyo", season: "Summer", seasonIcon: "summer", backgroundImage: "tokyo", text: getMockText())
        let rio = City(name: "Rio", season: "Spring", seasonIcon: "spring", backgroundImage: "rio", text: getMockText())
        
        cities.append(mexico)
        cities.append(beijing)
        cities.append(newdelhi)
        cities.append(capetown)
        cities.append(cairo)
        cities.append(istanbul)
        cities.append(moscow)
        cities.append(sydney)
        cities.append(newyork)
        cities.append(paris)
        cities.append(tokyo)
        cities.append(rio)
    }

    func getMockText() -> String{
        return "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae."
    }
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.setCell(city: cities[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.selectedIndexPath = indexPath
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        viewController.city = cities[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
     
    
    //MARK: - AnimatedViewController
    func zoomingBackgroundView(for transition: TransitionDelegate) -> UIView? {
            return nil
        }
        
    func zoomingImageView(for transition: TransitionDelegate) -> UIImageView?
    {
        if let indexPath = selectedIndexPath {
            let cell = tableView?.cellForRow(at: indexPath) as! MainTableViewCell
            return cell.backgroundImageView
        } else {
            return nil
        }
    }
    
    func zoomingTextsView(for transition: TransitionDelegate) -> UIView? {
        if let indexPath = selectedIndexPath {
            let cell = tableView?.cellForRow(at: indexPath) as! MainTableViewCell
            return cell.textsView
        } else {
            return nil
        }
    }
    
    func slidingTextView(for transition: TransitionDelegate) -> UIView? {
        return nil
    }
}

