//
//  CocktailsViewModel.swift
//  CocktailBook
//
//  Created by Arun Kumar on 10/12/2023.
//

import Foundation

let favouritesKey = "favourites"

class CocktailsViewModel: NSObject {
    
    private var cocktailService: CocktailsAPI
    var reloadTableView: (() -> Void)?
    var cocktails = Cocktails()
    var type: CocktailType?
    
    private var favourites:[String] {
        if let currentFavourites = UserDefaultsManager().retrieveFromUserDefaults(dataType: [String].self, key: favouritesKey){
            return currentFavourites
        }
        return []
    }
    
    var cocktailCellViewModels = [CocktailCellViewModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    var cocktailDetailsViewModels = [CocktailDetailsViewModel]()
    
    init(cocktailService: CocktailsAPI = FakeCocktailsAPI()) {
        self.cocktailService = cocktailService
    }
    
    func getCocktails() {
        cocktailService.fetchCocktails { success, model, error in
            if success, let cocktails = model {
                self.cocktails = cocktails
                self.fetchData(cocktails: cocktails)
            } else {
                print(error!)
            }
        }
    }
    func consideringfavourites(cocktails: Cocktails)->Cocktails{
        let cocktailsIncludingFavourite = cocktails.map {
            if(favourites.contains($0.id)){
                var favouriteCocktail = $0
                favouriteCocktail.favourite = true
                return favouriteCocktail
            }
            return $0
        }
        return cocktailsIncludingFavourite
    }
    
    func fetchData(cocktails: Cocktails) {
        
        let inclusiveOfFavourites = consideringfavourites(cocktails: cocktails).sorted { $0.name < $1.name }
        let sortedAlphabetically = inclusiveOfFavourites.sorted {($0.favourite ?? false && !($1.favourite ?? false))}
//        print("this is the sorted array \(sortedAlphabetically)")
        
        var cellViewModels = [CocktailCellViewModel]()
        var detailViewModels = [CocktailDetailsViewModel]()
        for cocktail in sortedAlphabetically {
            cellViewModels.append(createCellModel(cocktail: cocktail))
            detailViewModels.append(createDetailModel(cocktail: cocktail))
        }
        cocktailDetailsViewModels = detailViewModels
        cocktailCellViewModels = cellViewModels
    }
    
    func filterByType(type: CocktailType? = nil) {
        self.type = type
        if self.cocktails.count > 0{
            if let _ = type{
                let filteredCocktails = cocktails.filter { $0.type == type }
                self.fetchData(cocktails: filteredCocktails)
            }
            else{
                self.fetchData(cocktails: cocktails)
            }
        }
    }
        
    func createCellModel(cocktail: Cocktail) -> CocktailCellViewModel {
        let name = cocktail.name
        let shortDescription = cocktail.shortDescription
        var favourite = false
        if (favourites.count>0){
            favourite = favourites.contains(cocktail.id)
        }
        return CocktailCellViewModel(name: name, shortDescription: shortDescription, favourite: favourite)
    }
    
    func createDetailModel(cocktail: Cocktail) -> CocktailDetailsViewModel {
    
        let identifier = cocktail.id
        let name = cocktail.name
        let prepTime = "\(cocktail.preparationMinutes) minutes"
        let longDescription = cocktail.longDescription
        let imageName = cocktail.imageName
        let ingredients = cocktail.ingredients
        var favourite = false
        
        if (favourites.count>0){
            favourite = favourites.contains(cocktail.id)
        }
        return CocktailDetailsViewModel(identifier: identifier, name: name, preparationTime: prepTime, imageName: imageName, longDescription: longDescription, favourite: favourite, ingredients: ingredients)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CocktailCellViewModel {
            return cocktailCellViewModels[indexPath.row]
        }
    
    func getDetDetailViewModel(at indexPath: IndexPath) -> CocktailDetailsViewModel {
        return cocktailDetailsViewModels[indexPath.row]
    }
    
    func addToFavourites(identifier: String){
        
        var newFavourites = self.favourites.map{$0}
        if(!newFavourites.contains(identifier)){
            newFavourites.append(identifier)
            if (UserDefaultsManager().saveInUserDefaults(data: newFavourites, key: favouritesKey)){
                filterByType(type: type)
            }
        }
    }
    
    func removeFromFavourites(identifier: String){
        var newFavourites = self.favourites.map{$0}
        newFavourites.removeAll(where: { $0 == identifier })
        if (UserDefaultsManager().saveInUserDefaults(data: newFavourites, key: favouritesKey)){
            filterByType(type: type)
        }
    }
}

