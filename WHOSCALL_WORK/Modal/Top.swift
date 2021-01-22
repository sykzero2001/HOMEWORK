//
//  File.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/14.
//  Copyright © 2021 Dante. All rights reserved.
//

import Foundation
struct Top: Codable {
    let title : String?
    let type : String?
    let imageUrl : String?
    let rank : Int?
    let startDate : String?
    let endDate : String?
    let url :String?
    let mal_id:Int?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case type = "type"
        case imageUrl = "image_url"
        case rank = "rank"
        case startDate = "start_date"
        case endDate = "end_date"
        case url = "url"
        case mal_id = "mal_id"

    }
  
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        startDate = try values.decodeIfPresent(String.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        mal_id = try values.decodeIfPresent(Int.self, forKey: .mal_id)
    }
  
//
    static func readFavoriteData() -> [Top]?{
        let favoriteData  = UserDefaults.standard.data(forKey: "favorite")
        if favoriteData != nil {
            let decodeFavorite = try? PropertyListDecoder().decode(Array<Top>.self, from: favoriteData!)
            return decodeFavorite
        }else{
            return []
        }
    }
    static func setFavoriteData(data:[Top]?) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey:"favorite")
    UserDefaults.standard.synchronize()
    }
}
