//
//  ViewController.swift
//  RestWithSwift
//
//  Created by KBryan on 2015-12-17.
//  Copyright © 2015 KBryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Use JSON Placeholder for REST API
        let postEndPoint:String = "http://jsonplaceholder.typicode.com/posts/1"
        guard let url = NSURL(string: postEndPoint) else {
            print("Error: cannot create URL")
            return
        }
        /// create URL request with a valid URL
        let urlRequest = NSURLRequest(URL: url)
        /// configure the NSURL Session
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let completionHandler:(NSData?,NSURLResponse?,NSError?) -> Void = {
            (data,response,error) in
            guard let responseData = data else {
                print("Error: did not receive response")
                return
            }
            guard error == nil else {
                print("Error: calling GET on /post")
                print(error)
                return
            }
            /// past the result as JSON,
            let post:NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as! NSDictionary
            } catch {
                print("error trying to convert")
                return
            }
            print("The post is: " + post.description)
            /// the post object is a dictionary
            /// so we just access the title using "title" key
            if let postTitle = post["title"] as? String {
                print("The title is: " + postTitle)
            }
        }
        // create the data task
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
        task.resume()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

