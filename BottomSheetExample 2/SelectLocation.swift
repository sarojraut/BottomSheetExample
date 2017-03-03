//
//  SelectLocation.swift
//  BottomSheetExample
//
//  Created by Saroj on 3/1/17.
//  Copyright © 2017 Saroj. All rights reserved.
//

import UIKit
import MapKit

class SelectLocation: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchResultView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SearchVC Animation
    func addSearchResultView(){
       
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "frequentBottomVC") as! BottomLocationVCViewController
        
        searchVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height , width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(searchVC)
        self.view.addSubview(searchVC.view)
        searchVC.didMove(toParentViewController: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
