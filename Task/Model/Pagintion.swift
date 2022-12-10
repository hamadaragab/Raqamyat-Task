//
//  Pagintion.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct Pagination : Codable {
    let total : Int?
    let count : Int?
    let per_page : Int?
    let current_page : Int?
    let total_pages : Int?
    let links : Links?

    enum CodingKeys: String, CodingKey {

        case total = "total"
        case count = "count"
        case per_page = "per_page"
        case current_page = "current_page"
        case total_pages = "total_pages"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }

}
