//
//  TypeClass.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/14.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit

class TypeClass: NSObject {
    var typeName:String?
    var subType:[String]?
    init(name:String) {
        typeName = name
        var subTypeValueArray = [String]()
        if name == "anime" {
            subTypeValueArray = ["airing","upcoming","tv","movie","ova","special","bypopularity","favorite"]
        }else if name == "manga"{
            subTypeValueArray = ["manga","novels","oneshots","doujin","manhwa","manhua","bypopularity","favorite"]
        }else{
              subTypeValueArray = []
        }
        subType = subTypeValueArray
        
    }
}
