//
//  File.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct SuggestedProducts : Codable {
    let data : [ItemsData]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ItemsData].self, forKey: .data)
    }

}
