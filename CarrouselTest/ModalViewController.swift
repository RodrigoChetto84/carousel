//
//  ModalViewController.swift
//  CarrouselTest
//
//  Created by coton_ete on 20/7/17.
//  Copyright © 2017 RodrigoChetto. All rights reserved.
//

import Foundation
class ModalViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        let labelNotAvailable = UILabel(frame: CGRect(x: 0, y: (UIScreen.main.bounds.width)/2, width: UIScreen.main.bounds.width  * 0.85, height: 30.0))
        labelNotAvailable.center = view.center
        labelNotAvailable.textAlignment = .center
        labelNotAvailable.text = "No disponible"
        labelNotAvailable.backgroundColor = UIColor.lightGray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissModal(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)

        
        
        view.addSubview(labelNotAvailable)
    }
    
    func dismissModal(sender: UITapGestureRecognizer)
    {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }

}
