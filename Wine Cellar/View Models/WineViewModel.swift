//
//  WineViewModel.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/3/22.
//

import CoreData
import Foundation

final class WineViewModel: ObservableObject {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    let wineService: WineService!
    let tasteDetailsService: TasteDetailsService!
    let visualDetailsService: VisualDetailsService!
    let smellDetailsService: SmellDetailsService!
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wineService = WineService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
        self.tasteDetailsService = TasteDetailsService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
        self.visualDetailsService = VisualDetailsService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
        self.smellDetailsService = SmellDetailsService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
    }
    
    func addWine(dateAdded: Date = Date(),
                 abv: Float,
                 ava: String,
                 company: String,
                 isFavorited: Bool,
                 numberOwned: Int16,
                 type: String,
                 varietal: String,
                 vintage: Int16,
                 wineColor: String) -> Wine {
        return wineService.add(dateAdded: dateAdded, abv: abv, ava: ava, company: company, isFavorited: isFavorited, numberOwned: numberOwned, type: type, varietal: varietal, vintage: vintage, wineColor: wineColor)
    }
    
    func updateWine(_ wine: Wine) {
        wineService.update(wine)
    }
    
    func saveTasteDetails(
        body: Int16,
        sweetness: Int16,
        alcohol: Int16,
        acidityLevel: Int16,
        tanninLevel: Int16,
        wine: Wine
    ) {
        let tasteDetails = tasteDetailsService.add(body: body, sweetness: sweetness, alcohol: alcohol, acidityLevel: acidityLevel, tanninLevel: tanninLevel)
        addTasteDetails(tasteDetails, to: wine)
    }
    
    func saveVisualDetails(
        clarity: Int16,
        color: String,
        viscosity: Int16,
        wine: Wine
    ) {
        let visualDetails = visualDetailsService.add(color: color, viscosity: viscosity, clarity: clarity)
        addVisualDetails(visualDetails, to: wine)
    }
    
    func addTasteDetails(_ tasteDetails: TasteDetails, to wine: Wine) -> Wine {
        return wineService.addTasteDetails(tasteDetails, to: wine)
    
    }
    
    func addVisualDetails(_ visualDetails: VisualDetails, to wine: Wine) -> Wine {
        return wineService.addVisualDetails(visualDetails, to: wine)
    }
    
    func saveSmellDetails(
        date: Date,
        primaryAroma: [String],
        secondaryAroma: [String],
        tertiaryAroma: [String],
        wine: Wine
    ) {
        let smellDetails = smellDetailsService.add(date: date, primaryAroma: primaryAroma, secondaryAroma: secondaryAroma, tertiaryAroma: tertiaryAroma)
        addSmellDetails(smellDetails, to: wine)
    }
    
    func addSmellDetails(_ smellDetails: SmellDetails, to wine: Wine) -> Wine {
        return wineService.addSmellDetails(smellDetails, to: wine)
    }
}
