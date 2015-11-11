//
//  PhotosViewController.swift
//  
//
//  Created by Ngo Thanh Tai on 11/11/15.
//
//

import UIKit

class PhotosViewController: UIViewController {

    let urlString = "https://api.instagram.com/v1/media/popular?client_id=7937073861e0410fba7bf08d222832de"
    var photoData = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: urlString);
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if(error == nil) {
                let photoJson = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                self.photoData = photoJson["data"] as! [NSDictionary]
                print(self.photoData)
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
