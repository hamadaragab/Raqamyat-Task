//
//  ItemsDaata.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
struct ItemsData : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let rate : Int?
    let review_count : Int?
    let price : String?
    let old_price : String?
    let percentage : String?
    let image : String?
    let images : [String]?
    let size_chart : String?
    let is_fav : Bool?
    let colors : [Colors]?
    let sizes : [Sizes]?
    let reviews : [Reviews]?
    let suggestedProducts : SuggestedProducts?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case rate = "rate"
        case review_count = "review_count"
        case price = "price"
        case old_price = "old_price"
        case percentage = "percentage"
        case image = "image"
        case images = "images"
        case size_chart = "size_chart"
        case is_fav = "is_fav"
        case colors = "colors"
        case sizes = "sizes"
        case reviews = "reviews"
        case suggestedProducts = "suggestedProducts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        review_count = try values.decodeIfPresent(Int.self, forKey: .review_count)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        old_price = try values.decodeIfPresent(String.self, forKey: .old_price)
        percentage = try values.decodeIfPresent(String.self, forKey: .percentage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        size_chart = try values.decodeIfPresent(String.self, forKey: .size_chart)
        is_fav = try values.decodeIfPresent(Bool.self, forKey: .is_fav)
        colors = try values.decodeIfPresent([Colors].self, forKey: .colors)
        sizes = try values.decodeIfPresent([Sizes].self, forKey: .sizes)
        reviews = try values.decodeIfPresent([Reviews].self, forKey: .reviews)
        suggestedProducts = try values.decodeIfPresent(SuggestedProducts.self, forKey: .suggestedProducts)
    }

}
