//
//  NewsModel.swift
//  Daily
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import Foundation
import HandyJSON

class NewsModel: HandyJSON {
    
    var title     :String = ""
    var url       :String = ""
    var image     :String = ""
    var share_url :String = ""
    var thumbnail :String = ""
    var ga_prefix :String = ""
    var id        :String = ""
    required init() {
        
    }
}
