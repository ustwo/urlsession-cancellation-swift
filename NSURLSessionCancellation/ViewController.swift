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
    
    fileprivate let url = URL(string: "http://yahoo.com")!
    
    /// A default URL session
    
    fileprivate let session = URLSession(configuration: URLSessionConfiguration.default)

    
    // MARK: - UI Actions
    
    @IBAction func downloadButtonPressed(_ sender: AnyObject) {
        
        self.setLoadingSpinnerVisible(true)
        
        // Download data 
        
        self.session.dataTask(with: self.url, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async(execute: { 
             
                self.setLoadingSpinnerVisible(false)
                
                let titleAndMessage = self.createAlertTitleAndMessage(error as NSError?, data: data)
                let title = titleAndMessage.0
                let message = titleAndMessage.1
                
                self.showAlert(title, message: message)
            })
            
        }) .resume()
    }
    
    @IBAction func cancelAllButtonPressed(_ sender: AnyObject) {
        
        self.session.cancelAllRequests()
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        
        self.session.cancelRequestForURL(self.url)
    }
    
    
    // MARK: - Loading UI
    
     fileprivate func setLoadingSpinnerVisible(_ visible: Bool) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = visible
    }
    
    
    // MARK: - Alerts
    
    fileprivate func showAlert(_ title: String, message: String) {
        
        // Create an alert controller with ok button 
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func createAlertTitleAndMessage(_ error: NSError?, data: Data?) -> (String, String) {
        
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
