//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Terry Nguyen on 11/11/15.
//  Copyright © 2015 Ngo Thanh Tai. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedPhoto:NSDictionary?
    var photos = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
         photos = [selectedPhoto!]

        // Do any additional setup after loading the view.
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCellDetail", forIndexPath: indexPath) as! PhotoDetailCell
        let urlString = self.photos[indexPath.row].valueForKeyPath("images.standard_resolution.url") as! String
        cell.imageView?.setImageWithURL(NSURL(string: urlString)!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
}
