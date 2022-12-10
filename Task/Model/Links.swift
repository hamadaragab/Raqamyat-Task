//
//  Links.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Links : Codable {
    let next : String?

    enum CodingKeys: String, CodingKey {

        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }

}
