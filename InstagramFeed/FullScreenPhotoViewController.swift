//
//  FullScreenPhotoViewController.swift
//  InstagramFeed
//
//  Created by Baris Taze on 5/8/15.
//  Copyright (c) 2015 Baris Taze. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    
    var photoUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        
        let url = NSURL(string: photoUrl!)
        self.photoView.setImageWithURL(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return self.photoView
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
