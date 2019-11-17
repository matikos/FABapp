//
//  DetailViewController.swift
//  FABapp
//
//  Created by Your Host on 11/15/19.
//  Copyright © 2019 Mati Kos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    
    var type: String = "1"
    var price: String = ""
    var weight: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TypeLabel.text = type
        PriceLabel.text = price
        WeightLabel.text = weight
    }
    

    

}
