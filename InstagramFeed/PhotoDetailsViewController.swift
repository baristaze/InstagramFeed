//
//  PhotoDetailsViewController.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/6/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var photoUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = self.tableView.frame.height
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.insta.detail.row", forIndexPath: indexPath) as! PhotoDetailsTableCell
        
        let url = NSURL(string: self.photoUrl!)
        cell.photoItemView.setImageWithURL(url)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
