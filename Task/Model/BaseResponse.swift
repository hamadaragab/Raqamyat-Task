//
//  ItemsData.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct BaseResponse : Codable {
    let success : Bool?
    let item : Item?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case item = "item"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        item = try values.decodeIfPresent(Item.self, forKey: .item)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
