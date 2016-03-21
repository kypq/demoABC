//
//  ViewController.swift
//  MyApp
//
//  Created by Phan Quy Ky on 3/16/16.
//  Copyright © 2016 Phan Quy Ky. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var weatherIconUrl: UIImageView!
    @IBOutlet weak var temp_C: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    var dataOtherDate = []
    var coreData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource = self;
        weatherTableView.delegate = self;
        fetchData()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataOtherDate.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let basicCellIdentifier = "weatherTableViewCell"

        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! weatherTableViewCell
        cell.initData(self.dataOtherDate.objectAtIndex(indexPath.row))
        return cell
    }
    
    func saveDataDay (time:String, desc:String, url:String, tempC:String, windSpeed:String, hunidity:String){
        
        //create core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managerContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("DataWeather", inManagedObjectContext: managerContext)
        let dataWeather = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managerContext)
        
        dataWeather.setValue(time, forKey: "time")
        dataWeather.setValue(desc, forKey: "desc")
        dataWeather.setValue(url, forKey: "url")
        dataWeather.setValue(tempC, forKey: "tempC")
        dataWeather.setValue(windSpeed, forKey: "windSpeed")
        dataWeather.setValue(hunidity, forKey: "hunidity")

        do {
            try managerContext.save()
        } catch{
            print(error)
        }

    }
    
    func fetchData(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managerObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "DataWeather")
        
        do {
            let fetchResults = try managerObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            coreData = fetchResults
            print(coreData)
            
        } catch{
            print(error)
        }
        
        if coreData.count > 0 {
            let weather  = coreData[coreData.count-1]
            self.time.text = weather.valueForKey("time") as? String
            self.weatherDesc.text = weather.valueForKey("desc") as? String
            self.temp_C.text = weather.valueForKey("tempC") as? String
            self.windSpeed.text = weather.valueForKey("windSpeed") as? String
            self.humidity.text = weather.valueForKey("hunidity") as? String
            let url = weather.valueForKey("url") as? String
            let imageURL : NSURL = NSURL(string: url!)!
            self.weatherIconUrl.sd_setImageWithURL(imageURL)
            
        } else{
            getDataToCallAPI()
        }

    }
    
    func getDataToCallAPI(){
        
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.worldweatheronline.com/free/v1/weather.ashx?q=95014&format=json&num_of_days=5&key=urwds2jpg3uytmbygq47cmgn", parameters: nil, progress: nil, success: { (NSURLSessionTask task, responseObject) -> Void in
            
            let data = responseObject?.objectForKey("data")
            self.dataOtherDate = (data?.objectForKey("weather"))! as! NSArray
            
            self.weatherTableView.reloadData()
            
            let dataCurrentConfition   = data?.objectForKey("current_condition")?.objectAtIndex(0)
            self.location.text = "Cupertino, CA 95014, USA"
            self.time.text = (dataCurrentConfition?.objectForKey("observation_time"))! as? String
            self.weatherDesc.text = (dataCurrentConfition?.objectForKey("weatherDesc")?.objectAtIndex(0).objectForKey("value"))! as? String
            self.temp_C.text = (dataCurrentConfition?.objectForKey("temp_C"))! as? String
            self.windSpeed.text = (dataCurrentConfition?.objectForKey("windspeedKmph"))! as? String
            self.humidity.text = (dataCurrentConfition?.objectForKey("humidity"))! as? String
            let url = (dataCurrentConfition?.objectForKey("weatherIconUrl")?.objectAtIndex(0).objectForKey("value"))! as? String
            let imageURL : NSURL = NSURL(string: url!)!
            self.weatherIconUrl.sd_setImageWithURL(imageURL)
            
            self.saveDataDay(self.time.text!, desc: self.weatherDesc.text!, url: url!, tempC: self.temp_C.text!, windSpeed: self.windSpeed.text!, hunidity: self.humidity.text!)
            
            }) { (NSURLSessionTask operation, NSError error) -> Void in
                print(error);
                
                
        }

    }
    @IBAction func refeshTouch(sender: AnyObject) {
        getDataToCallAPI()
    }
    
    
}

