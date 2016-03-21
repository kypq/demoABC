//
//  weatherTableViewCell.swift
//  MyApp
//
//  Created by Phan Quy Ky on 3/16/16.
//  Copyright © 2016 Phan Quy Ky. All rights reserved.
//

import UIKit

class weatherTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var tempMaxC: UILabel!
    @IBOutlet weak var tempMinC: UILabel!
    @IBOutlet weak var speedWind: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initData (data : AnyObject){
        self.date.text = (data.objectForKey("date"))! as? String
        self.tempMaxC.text = (data.objectForKey("tempMaxC"))! as? String
        self.tempMinC.text = (data.objectForKey("tempMinC"))! as? String
        self.speedWind.text = (data.objectForKey("windspeedKmph"))! as? String
        
        let url = (data.objectForKey("weatherIconUrl")?.objectAtIndex(0).objectForKey("value"))! as? String
        let imageURL : NSURL = NSURL(string: url!)!
        self.imageWeather.sd_setImageWithURL(imageURL)
    }
    
}
