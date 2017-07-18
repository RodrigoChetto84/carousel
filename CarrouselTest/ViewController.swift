//
//  ViewController.swift
//  CarrouselTest
//
//  Created by coton_ete on 18/7/17.
//  Copyright © 2017 RodrigoChetto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    let carrouselJson = [
        [
            "title": "Carousel thumb",
            "type": "thumb",
            "items": [
                "title": "La Playa",
                "url": "",
                "video": ""
            ]
        ]
    ];
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrouselJson.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carousel = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! iCarousel
        return carousel as! UITableViewCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

