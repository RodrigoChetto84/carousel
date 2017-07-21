//
//  ViewController.swift
//  carouselTest
//
//  Created by coton_ete on 18/7/17.
//  Copyright © 2017 RodrigoChetto. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class CarouselTableViewCell: UITableViewCell, iCarouselDelegate, iCarouselDataSource {
    

    @IBOutlet var icarrousel: iCarousel!
    public var carouselDatasource: Carousel?
    public var imageArray: [UIImage?]=[]

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
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
        
        if let dataSource : Carousel = carouselDatasource {
            let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: dataSource.type.getWidth()  * UIScreen.main.bounds.width, height: (dataSource.type.getHeight()  * UIScreen.main.bounds.width)))

            tempView.tag = index
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPlayer(sender:)))
            tempView.isUserInteractionEnabled = true
            tempView.addGestureRecognizer(tapGestureRecognizer)

            tempView.backgroundColor = UIColor.lightGray
            if(imageArray.count == dataSource.items.count){
                tempView.image = imageArray[index]
            }
            
            
            
            let label = UILabel(frame: CGRect(x: 0, y: (dataSource.type.getHeight()  * UIScreen.main.bounds.width)-30, width: dataSource.type.getWidth()  * UIScreen.main.bounds.width, height: 30.0))
            let movie = carouselDatasource?.items[index]
            label.text = movie?.title
            label.textColor = dataSource.type.getTitleColor()
            label.font = dataSource.type.getTitleFont()
            
            label.backgroundColor = dataSource.type.getTitleBackgroundColor()
            label.textAlignment = .center
                
            tempView.addSubview(label)
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
    
    func openPlayer(sender: UITapGestureRecognizer)
    {
        
        //using sender, we can get the point in respect to the table view
        if let index = sender.view?.tag, let carrousel = self.carouselDatasource, let movie : Movie = carrousel.items[index] {
            if let url: String = movie.video, let videoURL = URL(string: url) {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.parentViewController?.present(playerViewController, animated: true) {
                    
                    playerViewController.player!.play()
                }
            } else {
                showModal()
            }
        }
    }
    
    func showModal() {
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        self.parentViewController?.present(modalViewController, animated: true)
    }

}


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
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
                    "video": "https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4"],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""],
                [
                    "title": "La Playa",
                    "url": "",
                    "video": ""]
            ]
        ],
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
        ],

        [
            "title": "Carousel poster",
            "type": "poster",
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
        var imageArray : [UIImage?]=[]

        
        if let carousel = Carousel(json: carouselJson[indexPath.item]) {
            
            if carouselCell.carouselDatasource == nil {
                carouselCell.carouselDatasource = carousel
                
                // preload images
                for _ in 0 ... carousel.items.count {
                    //get image, for our example this is always the same url
                    let url = URL(string: carousel.type.getImageString())
                    let session = URLSession.shared
                    let request = URLRequest(url:url!)
                    
                    let task = session.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async() {

                        if let downloadedImage = data, error == nil, let _ = response as? HTTPURLResponse {
                            //add image to array
                            let image = UIImage(data: downloadedImage)
                            imageArray.append(image)
                        } else {
                            //image not found
                            imageArray.append(nil)
                        }
                        //if all the images where retrieved (or if some failed)
                        if imageArray.count == carousel.items.count {
                            carouselCell.imageArray = imageArray
                            //add carrousel to cellView
                            let tempIcarrousel = iCarousel(frame: CGRect(x: 0, y: 0, width: (carousel.type.getWidth()) * UIScreen.main.bounds.width, height: (carousel.type.getHeight()) * UIScreen.main.bounds.width))
                            tempIcarrousel.dataSource = carouselCell.self
                            tempIcarrousel.delegate = carouselCell.self
                            
                            tempIcarrousel.center = CGPoint(x: carouselCell.contentView.frame.size.width  / 2, y: carouselCell.contentView.frame.size.height / 2)
                            tempIcarrousel.type = .rotary
                            
                            carouselCell.contentView.addSubview(tempIcarrousel)
                        }

                    }
                        
                        
                    }
                    

                    
                    task.resume()
                }
            }

        }
        return carouselCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if let carousel = Carousel(json: carouselJson[indexPath.item]) {
            return carousel.type.getHeight() * UIScreen.main.bounds.width
        } else {
            //set a default value in case that there is an invalid element
            return 100.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carrouselTableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: "carouselCell")
        carrouselTableView.delegate = self
        carrouselTableView.dataSource = self
        carrouselTableView.reloadData()
        carrouselTableView.allowsSelection = false

    }

}

