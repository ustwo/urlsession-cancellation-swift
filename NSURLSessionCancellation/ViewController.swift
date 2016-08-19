//
//  ViewController.swift
//  NSURLSessionCancellation
//
//  Created by Shagun Madhikarmi on 19/08/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private let url = NSURL(string: "http://yahoo.com")!

    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    // MARK: - Actions
    
    @IBAction func downloadButtonPressed(sender: AnyObject) {
        
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.session.dataTaskWithURL(url) { (data, response, error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            var message: String = ""
            var title: String = ""

            if let downloadError = error {
                
                if downloadError.domain == NSURLErrorDomain && downloadError.code == NSURLErrorCancelled {
                  
                    message = "Cancelled download for \(self.url) error: \(downloadError)"
                    title = "Cancelled"
                    
                } else {
                    
                    message = "Error downloading \(self.url) error: \(downloadError)"
                    title = "Error"
                }
     
            } else if let _ = data {
                
                message = "Success downloading data"
                title = "Success"
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.Cancel) { [weak self] (alertAction) -> Void in
                
                if let strongSelf = self {
                    
                    strongSelf.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)

            
            }.resume()
    }
    
    
    // MARK: - UI Actions
    
    @IBAction func cancelAllButtonPressed(sender: AnyObject) {
        
        self.session.cancelAllRequests()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self.session.cancelRequestForURL(self.url)
    }
}

