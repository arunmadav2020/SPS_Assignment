//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Arun Kumar on 10/12/2023.
//

import Foundation

typealias Cocktails = [Cocktail]

struct Cocktail: Codable{
    let id, name, shortDescription: String
    let type: CocktailType
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var favourite: Bool? = false
}
