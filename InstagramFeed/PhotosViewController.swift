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
    
    var infiniteLoadingStarted:Bool=false
    var tableFooterView:UIView!
    
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
        
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 55))
        var loadingView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        loadingView.startAnimating()
        loadingView.center = tableFooterView.center
        
        self.photos = NSMutableArray()
        
        self.loadMoreWithOptions(false, removeFooter: false);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadMoreWithOptions(endRefreshing:Bool, removeFooter:Bool){
        
        self.queryInstagramWithCallback({(data:NSArray)->(Void) in
            
            if(endRefreshing){
                var all = NSMutableArray(array: data as [AnyObject])
                all.addObjectsFromArray(self.photos as [AnyObject])
                self.photos = all
            }
            else {
                self.photos.addObjectsFromArray(data as [AnyObject])
            }
            
            self.tableView.reloadData()
            
            if(endRefreshing){
                self.refreshControl.endRefreshing()
            }
            
            if(removeFooter){
                self.infiniteLoadingStarted = false;
                self.tableFooterView.removeFromSuperview()
            }
        })
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
        self.loadMoreWithOptions(true, removeFooter: false);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.insta.row", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let feedItem = self.photos[indexPath.section] as! NSDictionary
        let itemImages = feedItem["images"] as! NSDictionary
        let thumbnail = itemImages["thumbnail"] as! NSDictionary
        let thumbnailUrl = thumbnail["url"] as! String
        let url = NSURL(string: thumbnailUrl)
        cell.photoItemView.setImageWithURL(url)
        
        var count = self.photos?.count ?? 0;
        if(!self.infiniteLoadingStarted && indexPath.section == (count-1)){
            self.tableView.tableFooterView = self.tableFooterView;
            self.loadMoreWithOptions(false, removeFooter: true);
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCellWithIdentifier("com.codepath.insta.header") as! PhotoTableHeaderCell
        
        let feedItem = self.photos[section] as! NSDictionary
        let userInfo = feedItem["user"] as! NSDictionary
        let username = userInfo["username"] as! String
        let profilePicUrl = userInfo["profile_picture"] as! String
        let url = NSURL(string: profilePicUrl)
        header.userPhotoView.setImageWithURL(url)
        header.userNameView.text = username
        
        return header
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.photos?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let feedItem = self.photos[indexPath!.section] as! NSDictionary
        let itemImages = feedItem["images"] as! NSDictionary
        let bigPhoto = itemImages["standard_resolution"] as! NSDictionary
        let bigPhotoUrl = bigPhoto["url"] as! String
        vc.photoUrl = bigPhotoUrl;
        
    }
}
