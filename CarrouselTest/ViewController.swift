//
//  ViewController.swift
//  carouselTest
//
//  Created by coton_ete on 18/7/17.
//  Copyright © 2017 RodrigoChetto. All rights reserved.
//

import UIKit



class CarouselTableViewCell: UITableViewCell, iCarouselDelegate, iCarouselDataSource {
    

    @IBOutlet var icarrousel: iCarousel!
    public var carouselDatasource: Carousel?
    
    let carouselJson = [
        [
            "title": "Carousel thumb",
            "type": "thumb",
            "items": [
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""]
            ]
        ]
    ];

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        carouselDatasource = Carousel(json: carouselJson[0])
        
        
        let tempIcarrousel = iCarousel()
        tempIcarrousel.dataSource = self
        tempIcarrousel.delegate = self
         tempIcarrousel.type = .coverFlow
         icarrousel = tempIcarrousel


        
        // code common to all your cells goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func numberOfItems(in carousel: iCarousel) -> Int {
        if let numberOfItems = carouselDatasource?.items.count {
            return numberOfItems
        } else {
            return 0
        }
        
    }

    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
       /* let tempView2 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        tempView2.backgroundColor = UIColor.red
        return tempView2
        */
        if let dataSource : Carousel = carouselDatasource {
            let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: dataSource.type.getWidth(), height: (dataSource.type.getHeight())))
            if let url = NSURL(string: dataSource.type.getImageString()){
            let session = URLSession.shared
            let task = session.downloadTask(with: url as URL)
            {
                (url: URL?, res: URLResponse?, e: Error?) in
                if let d = url?.dataRepresentation{
                    let image = UIImage(data: d)
                    DispatchQueue.main.async() {
                        tempView.image = image
                    }

                }
                
            }
            task.resume()
            }
            tempView.backgroundColor = UIColor.black
            return tempView

        } else {
            
            return UIView()
        }
    }
    
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if option == iCarouselOption.spacing {
            return 1.2
        }
        return value
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
}



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var carrouselTableView: UITableView!

    
    let carouselJson = [
        [
            "title": "Carousel thumb",
            "type": "thumb",
            "items": [
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""]
            ]
        ]
    ];
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carouselJson.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carouselCell = tableView.dequeueReusableCell(withIdentifier: "carouselCell") as! CarouselTableViewCell
        
        
        if let carousel = Carousel(json: carouselJson[indexPath.item]) {
            carouselCell.carouselDatasource = carousel
        }
        
        return carouselCell as UITableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carrouselTableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: "carouselCell")
        carrouselTableView.delegate = self
        carrouselTableView.dataSource = self
        carrouselTableView.reloadData()

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

