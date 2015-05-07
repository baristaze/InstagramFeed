//
//  PhotosViewController.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/6/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource {

    var photos:NSArray!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 320
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        var clientId = "d654efc721c344908eb0ba443d52ac7f"
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            self.photos = responseDictionary["data"] as! NSArray
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
