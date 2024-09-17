//
//  BikeFitV2Test.swift
//  BikeConfigurationAppTests
//
//  Created by Simon Hopkin on 17/09/2024.
//

import XCTest
@testable import BikeConfigurationApp

final class BikeFitV2Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBikeFitShouldCorrectlyCalculateSaddleXAndYGivenSaddleHeightAndAngle() throws {

        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 45,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 0,
                                              saddleToHandDrop: 0,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeSaddleXAndY()
        
        XCTAssertEqual(bikeFit.bbToSaddleX, 70.710678118654752, accuracy: 0.00000000001)
        XCTAssertEqual(bikeFit.bbToSaddleY, 70.710678118654752, accuracy: 0.00000000001)
    }
    
    func testBikeFitShouldCorrectlyCalculateHandXAndYGivenHandPositionAndSaddleXAndY() throws {

        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 45,
                                              bbToSaddleX: 20,
                                              bbToSaddleY: 80,
                                              saddleCentreToHand: 100,
                                              saddleToHandDrop: 10,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeHandXAndY()
        
        XCTAssertEqual(bikeFit.bbToHandX, 79.498743710661995, accuracy: 0.00000000001)
        XCTAssertEqual(bikeFit.bbToHandY, 70)
    }
}
