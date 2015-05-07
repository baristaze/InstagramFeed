//
//  PhotosViewController.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/6/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var photos:NSMutableArray!
    var refreshControl:UIRefreshControl!
    let clientId = "d654efc721c344908eb0ba443d52ac7f"
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias onInstagramData = (NSArray) -> (Void)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(self.refreshControl, atIndex: 0)
            
        self.tableView.rowHeight = 320
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.photos = NSMutableArray()
        
        self.queryInstagramWithCallback({(data:NSArray)->(Void) in
            self.photos.addObjectsFromArray(data as [AnyObject])
            self.tableView.reloadData()})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryInstagramWithCallback(callback:onInstagramData){
        
        // Do any additional setup after loading the view.
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            var data = responseDictionary["data"] as! NSArray
            callback(data)
        }
    }
    
    func onRefresh() {
        self.queryInstagramWithCallback({(data:NSArray)->(Void) in
            self.photos.addObjectsFromArray(data as [AnyObject])
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let feedItem = self.photos[indexPath.row] as! NSDictionary
        let itemImages = feedItem["images"] as! NSDictionary
        let thumbnail = itemImages["thumbnail"] as! NSDictionary
        let thumbnailUrl = thumbnail["url"] as! String
        let url = NSURL(string: thumbnailUrl)
        
        cell.photoItemView.setImageWithURL(url)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let feedItem = self.photos[indexPath!.row] as! NSDictionary
        let itemImages = feedItem["images"] as! NSDictionary
        let bigPhoto = itemImages["standard_resolution"] as! NSDictionary
        let bigPhotoUrl = bigPhoto["url"] as! String
        vc.photoUrl = bigPhotoUrl;
        
    }
}
