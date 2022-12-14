//
//  NotesService.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/24/22.
//

import CoreData
import Foundation

public final class TastingNotesService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension TastingNotesService {
    @discardableResult
    public func add(noteOrigin: Int16, tastingNoteText: String) -> TastingNote {
        let tastingNote = TastingNote(context: managedObjectContext)
        tastingNote.noteOrigin = noteOrigin
        tastingNote.tastingNoteText = tastingNoteText
        
        coreDataStack.saveContext(managedObjectContext)
        return tastingNote
    }
    
    public func getTastingNotes() -> [TastingNote]? {
        let tastingNoteFetch: NSFetchRequest<TastingNote> = TastingNote.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(tastingNoteFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getTastingNote(with id: NSManagedObjectID) -> TastingNote? {
        let result = managedObjectContext.object(with: id)
        return result as? TastingNote
        
    }

//    func addWineToTastingNote(_ tastingNote: TastingNote, wine: Wine) -> TastingNote {
//        let newTastingNote = TastingNote(context: managedObjectContext)
//        newTastingNote.noteOrigin = tastingNote.noteOrigin
//        newTastingNote.tastingNoteText = tastingNote.tastingNoteText
//        
//        wine.addToTastingNotes(newTastingNote)
//        
//        coreDataStack.saveContext(managedObjectContext)
//        return 
//    }
  
    @discardableResult
    public func update(_ tastingNote: TastingNote) -> TastingNote {
        coreDataStack.saveContext(managedObjectContext)
        return tastingNote
    }
    
    public func delete(_ tastingNote: TastingNote) {
        managedObjectContext.delete(tastingNote)
        coreDataStack.saveContext(managedObjectContext)
    }
}
