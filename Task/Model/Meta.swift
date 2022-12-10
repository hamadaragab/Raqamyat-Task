//
//  Meta.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Meta : Codable {
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}
