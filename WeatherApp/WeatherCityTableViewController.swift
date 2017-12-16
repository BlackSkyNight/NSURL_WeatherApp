//
//  WeatherCityTableViewController.swift
//  WeatcherApp
//
//  Created by Mateusz Matejczyk on 14.12.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
// https://www.youtube.com/watch?v=doqtsIsbtqs 9:18 collectionView in cell https://www.youtube.com/watch?v=6ZxA2pmV3VM

import UIKit
import CoreLocation

class WeatherCityTableViewController: UITableViewController, UISearchBarDelegate {

    //init
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var myTableView: UITableView!
    
    var forecastData = [Weather]()
    var numberOfSavedCitys = 1
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty
        {
            updateWeatherForLocation(location: locationString)
        }
    }
    
    func updateWeatherForLocation(location: String)
    {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil
            {
                if let location = placemarks?.first?.location
                {
                    Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
                        if let weatherData = results
                        {
                            self.forecastData = weatherData
                            self.loaded = true
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell

        let weatherObject = forecastData.first
        cell.nameDayLabel.text = "today"
        cell.namePlaceLabel.text = ""
        
        if (weatherObject?.temperature != nil)
        {
        cell.temperatureLabel.text = "\(Int((weatherObject?.temperature)!))"
        }
        else
        {
            cell.temperatureLabel.text = "999"
        }
        print("\(weatherObject?.icon)")
        
        if loaded == true && weatherObject?.icon != nil
        {
            cell.iconImage?.image = UIImage(named: weatherObject!.icon)
        }
        else
        {
            
            cell.iconImage?.image = UIImage(named: "clear_day")
        }
        cell.updateCollection()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WeatherCityTableViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! DetailCollectionViewCell
      
        var weatherObject = forecastData.first
        
        if (forecastData.count > 1)
        {
            weatherObject = forecastData[indexPath.row]
        }
        
        if (weatherObject?.temperature != nil)
        {
            cell.temperatureLabel.text = "\(Int((weatherObject?.temperature)!))"
        }
        else
        {
            cell.temperatureLabel.text = "999"
        }
        
        if (weatherObject?.icon != nil)
        {
            cell.iconImage.image = UIImage(named: (weatherObject?.icon)!)
        }
            
        let date = Calendar.current.date(byAdding: .weekday, value: indexPath.row, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        dateFormatter.dateFormat = "EEEE"
        cell.dateLabel.text = dateFormatter.string(from: date!)
        
 
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}











