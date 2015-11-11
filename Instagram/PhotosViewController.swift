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

    let urlString = "https://api.instagram.com/v1/media/popular?client_id=7937073861e0410fba7bf08d222832de"
    var photoData = [NSDictionary]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = 32

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        let photo = photoData[indexPath.row]
        cell.lbUserName.text = photo.valueForKeyPath("user.username") as! String
        cell.imgPhoto.setImageWithURL(NSURL(string:photo.valueForKeyPath("images.thumbnail.url") as! String)!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoData.count
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
