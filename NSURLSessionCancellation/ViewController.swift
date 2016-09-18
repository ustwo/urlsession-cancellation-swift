//
//  ViewController.swift
//  NSURLSessionCancellation
//
//  Created by Shagun Madhikarmi on 19/08/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // A sample URL that takes a while to download (so that cancellaton can be demonstrated)
    
    private let url = NSURL(string: "http://yahoo.com")!
    
    /// A default URL session
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    
    // MARK: - UI Actions
    
    @IBAction func downloadButtonPressed(sender: AnyObject) {
        
        self.setLoadingSpinnerVisible(true)
        
        // Download data 
        
        self.session.dataTaskWithURL(self.url) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), { 
             
                self.setLoadingSpinnerVisible(false)
                
                let titleAndMessage = self.createAlertTitleAndMessage(error, data: data)
                let title = titleAndMessage.0
                let message = titleAndMessage.1
                
                self.showAlert(title, message: message)
            })
            
        }.resume()
    }
    
    @IBAction func cancelAllButtonPressed(sender: AnyObject) {
        
        self.session.cancelAllRequests()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
        self.session.cancelRequestForURL(self.url)
    }
    
    
    // MARK: - Loading UI
    
     private func setLoadingSpinnerVisible(visible: Bool) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
    }
    
    
    // MARK: - Alerts
    
    private func showAlert(title: String, message: String) {
        
        // Create an alert controller with ok button 
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func createAlertTitleAndMessage(error: NSError?, data: NSData?) -> (String, String) {
        
        // Create title and message for an alert based on whether there was an error or if there is data
        
        var message: String = ""
        var title: String = ""
        
        if let error = error {
            
            if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                
                title = NSLocalizedString("Cancelled", comment: "")
                message = NSLocalizedString("Cancelled download for \(self.url) error: \(error)", comment: "")
                
            } else {
                
                title = NSLocalizedString("Error", comment: "")
                message = NSLocalizedString("Error downloading \(self.url) error: \(error)", comment: "")
            }
            
        } else if let _ = data {
            
            title = NSLocalizedString("Success", comment: "")
            message = NSLocalizedString("Success downloading data", comment: "")
        }
        
        return (title, message)
    }
}
