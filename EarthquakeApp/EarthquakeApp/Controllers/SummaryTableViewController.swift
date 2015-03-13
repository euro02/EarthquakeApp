//
//  SummaryTableViewController.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 11/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy

class SummaryTableViewController: UITableViewController {
    
    @IBOutlet weak var mapIconBar: UIBarButtonItem!
    var collection: FeatureCollection!
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPullToRefresh()
        fillCacheData()
        requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (collection != nil) {
            return collection!.metadata!.count!
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = collection.features![indexPath.row].properties!.place!
        cell.detailTextLabel?.text = "Magnitude: " + collection.features![indexPath.row].properties!.mag!.description
        cell.backgroundColor = getColorFromMagnitude(collection.features![indexPath.row].properties!.mag!)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    @IBAction func refreshTapped(sender: AnyObject) {
        requestData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)  {
        if segue.identifier == "viewDetails" {
            let selectedRow = tableView.indexPathForSelectedRow()?.row
            let feature: Feature = collection!.features![selectedRow!]
            let detailViewController = segue.destinationViewController as DetailViewController
            detailViewController.feature = feature
        } else {
            let mapViewController = segue.destinationViewController as MapViewController
            mapViewController.collection = collection
            mapViewController.title = self.title
        }
    }
    
    func registerPullToRefresh(){
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("pullToRefreshAction"), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl = refreshControl
    }
    
    func pullToRefreshAction() {
        requestData()
        refreshControl?.endRefreshing()
    }
    
    func fillCacheData(){
        if(prefs.objectForKey("cache") != nil) {
            let cacheData:NSData = prefs.objectForKey("cache") as NSData
            self.collection = FeatureCollection(JSONDecoder(cacheData))
            self.title = self.collection.metadata!.title!
            self.tableView.reloadData()
        } else {
            mapIconBar.enabled = false
        }
    }
    
    func requestData(){
        self.tableView.tableFooterView = UIView()
        var request = HTTPTask()
        request.GET("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson", parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_sync(dispatch_get_main_queue()) {
                    self.prefs.setObject(data, forKey: "cache")
                    self.mapIconBar.enabled = true
                    self.prefs.synchronize()
                    self.collection = FeatureCollection(JSONDecoder(data))
                    self.title = self.collection.metadata!.title!
                    self.tableView.reloadData()
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                dispatch_sync(dispatch_get_main_queue()) {
                    Utils.popUpMessage("Information is not updated")
                }
        })
    }
    
    func getColorFromMagnitude(color:Double)->UIColor{
        switch(color){
        case 0...0.9: return Utils.UIColorFromRGB(0x00AA53)
        case 0.9...4: return Utils.UIColorFromRGB(0x207CE5)
        case 4...6: return Utils.UIColorFromRGB(0xF9DC4A)
        case 6...8.99: return Utils.UIColorFromRGB(0xD1AA10)
        case 9...9.9: return Utils.UIColorFromRGB(0x8D0222)
        default: return Utils.UIColorFromRGB(0x000000)
        }
    }
    
}
