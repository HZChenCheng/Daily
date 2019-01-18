//
//  NewsDetailViewController.swift
//  Daily
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SnapKit
import WebKit
import Kingfisher
import SwiftyJSON
import Alamofire

class NewsDetailViewController: UIViewController {
    
    var url: String?
    var adImageView:UIImageView?
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        Alamofire.request(url!).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                return
            }
            
            let jsonDict = JSON(response.result.value as Any).dictionary
            var body = jsonDict?["body"]?.string
            let image = jsonDict?["image"]?.string
            
            let url = URL(string: image!)
            self.adImageView?.kf.setImage(with: url)
            
            var imageString = String()
            imageString.append("<div style=\"overflow: hidden\" class=\"img-place-holder\"\">")
            imageString.append("</div>")
            
            body = (body?.replacingOccurrences(of: "<div class=\"img-place-holder\"></div>", with: imageString))!
            var newsString = String()
            
            newsString.append("<html>")
            newsString.append("<head>")
            
            let other = "<meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">"
            newsString.append(other)
            
            let cssString = jsonDict?["css"]?[0].string
            let css = "<link rel=\"stylesheet\" href=" + cssString!  + ">"
            newsString.append(css)
            
            newsString.append("</head>")
            newsString.append("<body>")
            newsString.append(body!)
            newsString.append("</body>")
            newsString.append("</html>")
            
            self.webView?.loadHTMLString(newsString, baseURL: nil)
            
        }
    }
    
    
    func setupUI() {
        
        webView = WKWebView()
        webView?.sizeToFit()
        view.addSubview(webView!)
        
        webView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        adImageView = UIImageView()
        adImageView?.contentMode = .scaleAspectFill
        adImageView?.clipsToBounds = true
        webView?.scrollView.addSubview(adImageView!)
        adImageView?.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

