//
//  ViewController.swift
//  Ace Edventure
//
//  Created by Rifa Fauziah on 31/05/2024.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    var notiURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a WKWebViewConfiguration instance
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        
        // Initialize the webView with the configuration
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.navigationDelegate = self
        
        // Add the webView to the view hierarchy
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
            print("notiurl = \(notiURL ?? "")")
        // Check internet connection
        checkInternetConnection { isConnected in
        DispatchQueue.main.async {
            if isConnected {
                print("notiurl = \(self.notiURL ?? "")")
                if self.notiURL == nil{
                    self.loadPage()
                }else{
                    self.loadPage(url: self.notiURL)
                }
            } else {
                self.loadNoConnectionPage()
            }
        }
    }

    }
    
    // Start the activity indicator when navigation starts
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    // Stop the activity indicator when navigation finishes
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    // Load the initial web page
    func loadPage(url:String? = nil) {
        
        
        
        if url == nil{
            let loginURL = URL(string: "https://teacher.aceedventure.com/teacher/")!
            var request = URLRequest(url: loginURL)
            checkInternetConnection { isConnected in
                DispatchQueue.main.async {
                    
                    if isConnected {
                        
                        request.cachePolicy = .useProtocolCachePolicy
                    } else {
                        request.cachePolicy = .returnCacheDataElseLoad
                    }
                }
            }
            
                webView.load(request)
           
        }else{
            let loginURL = URL(string: url!)!
            var request = URLRequest(url: loginURL)
            checkInternetConnection { isConnected in
                DispatchQueue.main.async {
                    
                    if isConnected {
                        
                        request.cachePolicy = .useProtocolCachePolicy
                    } else {
                        request.cachePolicy = .returnCacheDataElseLoad
                    }
                }
            }
            
            webView.load(request)
            
        }
        
    }
      
    
        func loadNoConnectionPage() {
                if let filePath = Bundle.main.path(forResource: "no_connection", ofType: "html") {
                    let fileURL = URL(fileURLWithPath: filePath)
                    webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
                }
            }
    }
    
