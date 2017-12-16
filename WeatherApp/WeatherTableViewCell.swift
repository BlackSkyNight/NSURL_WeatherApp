//
//  WeatherTableViewCell.swift
//  WeatcherApp
//
//  Created by Mateusz Matejczyk on 14.12.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    // init elements
    
    @IBOutlet weak var namePlaceLabel: UILabel!
    @IBOutlet weak var nameDayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCollection()
    {
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }

}
