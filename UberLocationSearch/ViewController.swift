//
//  ViewController.swift
//  UberLocationSearch
//
//  Created by Anh Dinh on 3/11/21.
//

import UIKit
import MapKit
import FloatingPanel

class ViewController: UIViewController {

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        title = "Uber"
        
        // use CocoaPods to import FloatingPanel
        let panel = FloatingPanelController()
        //Sets the view controller responsible for the content portion of a panel.
        panel.set(contentViewController: SearchViewController())
        // add this panel to this viewController so when we load the app we can see it
        panel.addPanel(toParent: self)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
     
    
}

