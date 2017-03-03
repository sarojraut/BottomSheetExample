//
//  BottomLocationVCViewController.swift
//  BananaBike
//
//  Created by Saroj on 1/24/17.
//  Copyright © 2017 Saroj. All rights reserved.
//

import UIKit
import MapKit

class BottomLocationVCViewController: UIViewController {
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    var fullView: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForBottomAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tblView.tableFooterView = UIView()
        tblView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateAfterViewAppear()
    }
}
//MARK:- Table View Datasource and delegate
extension BottomLocationVCViewController : UITableViewDataSource , UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath as IndexPath) as? FavouriteBottomVCTableViewCell
        
                return cell!
        }
    }

extension BottomLocationVCViewController:UIGestureRecognizerDelegate{
    func addGestureForBottomAnimation(){
        let swipedOnImage = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(recognizer:)))
        view.addGestureRecognizer(swipedOnImage)
        view.isUserInteractionEnabled = true
        swipedOnImage.delegate = self
    }
    
        //MARK:- Animate afterViewWill Appear
    func animateAfterViewAppear(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
//MARK:- animate by dragging view
    func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation( in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        //translate y postion when drag within fullview to partial view
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.5 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
                }, completion: { [weak self] _ in
                    if ( velocity.y < 0 ) {
                        self?.tblView.isScrollEnabled = true
                    }
                })
            }
        }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        let y = view.frame.minY
            if (y == fullView && tblView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
                self.tblView.isScrollEnabled = false
            } else {
                self.tblView.isScrollEnabled = true
            }
        
        return false
    }
}

