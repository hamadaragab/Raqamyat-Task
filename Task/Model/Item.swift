//
//  Item.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Item : Codable {
    let data : [ItemsData]?
    let meta : Meta?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case meta = "meta"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ItemsData].self, forKey: .data)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }

}
