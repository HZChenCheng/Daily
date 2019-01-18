//
//  ViewController.swift
//  Daily
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {
    
    var collectionView:UICollectionView?
    var news:[NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        requestData()
    }
    
    func requestData() {
        
        Alamofire.request("http://news.at.zhihu.com/api/1.2/stories/latest").responseJSON { (response) in
            
            guard response.result.isSuccess else {
                return
            }
            
            let jsonDict = JSON(response.result.value as Any)
            if let arr = jsonDict["news"].arrayObject {
                for item in arr {
                    let model = NewsModel.deserialize(from: (item as! Dictionary))
                    self.news.append(model!)
                }
                print(self.news)
                self.collectionView?.reloadData()
                
            }
        }
    }
    
    func setupUI() {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 124);
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        collectionView?.alwaysBounceVertical  = true
        collectionView?.backgroundColor = UIColor.darkGray
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
        cell.backgroundColor = UIColor.white
        cell.newsModel = news[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = news[indexPath.item]
        let newsDetailVc = NewsDetailViewController()
        newsDetailVc.url = model.url
        navigationController?.pushViewController(newsDetailVc, animated: true)
    }
}


