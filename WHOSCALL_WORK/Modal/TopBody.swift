//
//  TopBody.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/15.
//  Copyright © 2021 Dante. All rights reserved.
//

import Foundation
struct TopBody: Codable {
    let request_hash : String?
    let request_cached :Bool?
    let request_cache_expiry : Int?
    let top : [Top]?
    enum CodingKeys: String, CodingKey {
        case request_hash = "request_hash"
        case request_cached = "request_cached"
        case request_cache_expiry = "request_cache_expiry"
        case top = "top"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        request_hash = try values.decodeIfPresent(String.self, forKey: .request_hash)
        request_cached = try (values.decodeIfPresent(Bool.self, forKey: .request_cached))
        request_cache_expiry = try (values.decodeIfPresent(Int.self, forKey: .request_cache_expiry))
        top = try values.decodeIfPresent([Top].self, forKey: .top)
    }
}
