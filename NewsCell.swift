//
//  NewsCell.swift
//  Daily
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NewsCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var imageView: UIImageView!
    public var newsModel: NewsModel? {
        didSet {
            
            titleLabel.text = newsModel?.title
            
            let url = URL(string: newsModel?.image ?? "")
            imageView.kf.setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 156
        contentView.addSubview(titleLabel)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(imageView.snp.left).offset(-12)
            make.top.equalTo(imageView)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width - 20)
            make.height.greaterThanOrEqualTo(124)
        }
    }
    
    
}
