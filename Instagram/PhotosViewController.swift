//
//  PhotosViewController.swift
//  
//
//  Created by Ngo Thanh Tai on 11/11/15.
//
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let urlString = "https://api.instagram.com/v1/media/popular?client_id=7937073861e0410fba7bf08d222832de"
    var photoData = [NSDictionary]()
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        let url = NSURL(string: urlString);
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if(error == nil) {
                let photoJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                self.photoData = photoJson["data"] as! [NSDictionary]
                //print(self.photoData)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
        task.resume()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        let photo = photoData[indexPath.row]
        cell.lbUserName.text = photo.valueForKeyPath("user.username") as? String
        cell.imgPhoto.setImageWithURL(NSURL(string:photo.valueForKeyPath("images.thumbnail.url") as! String)!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoData.count
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let photoViewDetail = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = tableView.indexPathForCell((sender as? UITableViewCell)!)
        let selectedPhoto = self.photoData[indexPath!.row]
        photoViewDetail.photos = [selectedPhoto]
    }


    func onRefresh() {
        delay(2, closure: {
          self.refreshControl.endRefreshing()
        })
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
