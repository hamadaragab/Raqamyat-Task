//
//  Colors.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Colors : Codable {
    let id : Int?
    let name : String?
    let color_hex : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case color_hex = "color_hex"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        color_hex = try values.decodeIfPresent(String.self, forKey: .color_hex)
    }

}
