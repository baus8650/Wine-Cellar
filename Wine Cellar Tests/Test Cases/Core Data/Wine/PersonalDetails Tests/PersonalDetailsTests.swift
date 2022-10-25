import CoreData
@testable import Wine_Cellar
import XCTest

final class PersonalDetailsTest: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var personalDetailsService: PersonalDetailsService!
    let newPersonalDetails = PersonalDetailsBuilder().build()
    let secondPersonalDetails = PersonalDetailsBuilder()
        .opinions("Second Opinion")
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        personalDetailsService = PersonalDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        personalDetailsService = nil
    }
    
    func testAddTasteDetails() throws {
        let personalDetails = personalDetailsService.add(opinion: newPersonalDetails.opinions, mood: newPersonalDetails.mood)
        XCTAssertEqual(personalDetails.opinion, "Test Opinion")
    }
    
    func testGetAllPersonalDetails() throws {
        let _ = personalDetailsService.add(opinion: newPersonalDetails.opinions, mood: newPersonalDetails.mood)
        let _ = personalDetailsService.add(opinion: secondPersonalDetails.opinions, mood: secondPersonalDetails.mood)
        let personalDetails = personalDetailsService.getPersonalDetails()
        XCTAssertEqual(personalDetails?.count, 2)
    }
    
    func testGetSingleTasteDetail() throws {
        let personalDetails1 = personalDetailsService.add(opinion: newPersonalDetails.opinions, mood: newPersonalDetails.mood)
        let personalDetails2 = personalDetailsService.add(opinion: secondPersonalDetails.opinions, mood: secondPersonalDetails.mood)
        
        let fetchedPersonalDetails1 = personalDetailsService.getPersonalDetails(with: personalDetails1.objectID)
        let fetchedPersonalDetails2 = personalDetailsService.getPersonalDetails(with: personalDetails2.objectID)
        XCTAssertEqual(fetchedPersonalDetails1?.opinion, "Test Opinion")
        XCTAssertEqual(fetchedPersonalDetails2?.opinion, "Second Opinion")
    }
    
    func testUpdateTasteDetails() throws {
        let personalDetails1 = personalDetailsService.add(opinion: newPersonalDetails.opinions, mood: newPersonalDetails.mood)
        let oldPersonalDetails = personalDetailsService.getPersonalDetails(with: personalDetails1.objectID)
        XCTAssertEqual(oldPersonalDetails?.opinion, "Test Opinion")
        
        let updatedPersonalDetails = personalDetailsService.getPersonalDetails(with: personalDetails1.objectID)
        updatedPersonalDetails?.opinion = "Updated Opinion"
        personalDetailsService.update(updatedPersonalDetails!)
        
        let newPersonalDetails = personalDetailsService.getPersonalDetails(with: personalDetails1.objectID)
        XCTAssertEqual(newPersonalDetails?.opinion, "Updated Opinion")
    }
    
    func testDeleteTasteDetails() throws {
        let _ = personalDetailsService.add(opinion: newPersonalDetails.opinions, mood: newPersonalDetails.mood)
        let personalDetails2 = personalDetailsService.add(opinion: secondPersonalDetails.opinions, mood: secondPersonalDetails.mood)
        
        var personalDetails = personalDetailsService.getPersonalDetails()
        XCTAssertEqual(personalDetails?.count, 2)
        
        let personalDetailsToDelete = personalDetailsService.getPersonalDetails(with: personalDetails2.objectID)
        personalDetailsService.delete(personalDetailsToDelete!)
        personalDetails = personalDetailsService.getPersonalDetails()
        XCTAssertEqual(personalDetails?.count, 1)
        XCTAssertEqual(personalDetails?[0].opinion, "Test Opinion")
    }
    
}
