//
//  CocktailDetailViewModel.swift
//  CocktailBook
//
//  Created by Arun Kumar on 11/12/2023.
//

import Foundation

struct CocktailDetailsViewModel {
    var identifier: String
    var name: String
    var preparationTime: String
    var imageName: String
    var longDescription: String
    var favourite: Bool = false
    var ingredients: [String]
    
    func getCellViewModel(at indexPath: IndexPath) -> IngredientsCellViewModel? {
        let name = ingredients[indexPath.row]
        return IngredientsCellViewModel(ingredientName: name)
    }
    
    
}
