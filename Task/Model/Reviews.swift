//
//  Reviews.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Reviews : Codable {
    let id : Int?
    let rate : Int?
    let review : String?
    let title : String?
    let created_by : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case rate = "rate"
        case review = "review"
        case title = "title"
        case created_by = "created_by"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
