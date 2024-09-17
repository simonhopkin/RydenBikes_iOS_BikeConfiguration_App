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

    func testBikeFitShouldCorrectlyComputeSaddleXAndYGivenSaddleHeightAndAngle() throws {

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
        
        XCTAssertEqual(bikeFit.bbToSaddleX, 70.710678118654752, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 70.710678118654752, accuracy: 1e-13)
    }
    
    func testBikeFitShouldCorrectlyComputeGripXAndYGivenGripPositionAndSaddleXAndY() throws {

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
        
        XCTAssertEqual(bikeFit.bbToHandX, 79.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 70)
    }
    
    func testBikeFitShouldCorrectlyComputeHandlebarXAndYGivenHandlebarHeightAndAngle() throws {
        
        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 0,
                                              bbToSaddleAngle: 0,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 0,
                                              saddleToHandDrop: 0,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 100,
                                              bbToHandlebarAngle: 45,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeHandlebarXAndY()
        
        XCTAssertEqual(bikeFit.bbToHandlebarX, 70.710678118654752, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandlebarY, 70.710678118654752, accuracy: 1e-13)
    }
    
    func testBikeFitShouldCorrectlyUpdateSaddleXAndYAndGripPositionWhenSaddleHeightIsUpdated() throws {

        //saddle height change - recalculate saddle x and saddle y (saddle angle stays fixed)
        //  then recalculate saddle centre to grip and saddle to grip drop (grip x and y stay fixed)
        
        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 60,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 100,
                                              saddleToHandDrop: 10,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeSaddleXAndY()
        bikeFit.computeHandXAndY()

        // check initial state of computed x and y properties as expected after entering saddle and grip position properties
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 60)
        XCTAssertEqual(bikeFit.bbToSaddleX, 50, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 86.602540378443865, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 100)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 10)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
        
        // update saddle height
        
        bikeFit.bbToSaddleCentre = 125
        
        // saddle x and y should change (saddle height and angle remain fixed), and grip position should change (grip x and grip y remain the same)
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 125)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 60, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleX, 62.5, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 108.253175473054831, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 116.385056148367985, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 31.65063509461094, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
    }
    
    func testBikeFitShouldCorrectlyUpdateSaddleXAndYAndGripPositionWhenSaddleAngleIsUpdated() throws {

        //saddle angle change - recalculate saddle x and saddle y (saddle height stays fixed)
        //  then recalculate saddle centre to grip and saddle to grip drop (grip x and y stay fixed)
        
        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 60,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 100,
                                              saddleToHandDrop: 10,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeSaddleXAndY()
        bikeFit.computeHandXAndY()

        // check initial state of computed x and y properties as expected after entering saddle and grip position properties
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 60)
        XCTAssertEqual(bikeFit.bbToSaddleX, 50, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 86.602540378443865, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 100)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 10)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
        
        // update saddle angle
        
        bikeFit.bbToSaddleAngle = 70
        
        // saddle x and y should change (saddle height and angle remain fixed), and grip position should change (grip x and grip y remain the same)
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 70, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleX, 34.202014332566873, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 93.969262078590838, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 85.483448220234415, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 17.36672170014698, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
    }
    
    func testBikeFitShouldCorrectlyUpdateSaddleYAndAngleAndGripPositionWhenSaddleXIsUpdated() throws {

        //saddle x change - recalculate saddle height and angle (saddle y stays fixed)
        //  then recalculate saddle centre to grip and saddle to grip drop (grip x and y stay fixed)
        
        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 60,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 100,
                                              saddleToHandDrop: 10,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeSaddleXAndY()
        bikeFit.computeHandXAndY()

        // check initial state of computed x and y properties as expected after entering saddle and grip position properties
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 60)
        XCTAssertEqual(bikeFit.bbToSaddleX, 50, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 86.602540378443865, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 100)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 10)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
        
        // update saddle x
        
        bikeFit.bbToSaddleX = 25
        
        // saddle y and angle should change (saddle height remains fixed), and grip position should change (grip x and grip y remain the same)
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 75.522487814070076, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleX, 25)
        XCTAssertEqual(bikeFit.bbToSaddleY, 96.824583655185422, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 77.194519551282327, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 20.22204327674156, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
    }
    
    func testBikeFitShouldCorrectlyUpdateSaddleHeightAndAngleAndGripPositionWhenSaddleYIsUpdated() throws {

        //saddle y change - recalculate saddle height and angle (saddle x stays fixed)
        //  then recalculate saddle centre to grip and saddle to grip drop (grip x and y stay fixed)
        
        let bikeFit = BikeFitSchemaV2.BikeFit(name: "bike fit",
                                              notes: "notes",
                                              bbToSaddleCentre: 100,
                                              bbToSaddleAngle: 60,
                                              bbToSaddleX: 0,
                                              bbToSaddleY: 0,
                                              saddleCentreToHand: 100,
                                              saddleToHandDrop: 10,
                                              bbToHandX: 0,
                                              bbToHandY: 0,
                                              bbToHandlebarCentre: 0,
                                              bbToHandlebarAngle: 0,
                                              bbToHandlebarX: 0,
                                              bbToHandlebarY: 0)
        
        bikeFit.computeSaddleXAndY()
        bikeFit.computeHandXAndY()

        // check initial state of computed x and y properties as expected after entering saddle and grip position properties
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 100)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 60)
        XCTAssertEqual(bikeFit.bbToSaddleX, 50, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 86.602540378443865, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 100)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 10)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
        
        // update saddle y
        
        bikeFit.bbToSaddleY = 100
        
        // saddle height and angle should change (saddle x remains fixed), and grip position should change (grip x and grip y remain the same)
        
        XCTAssertEqual(bikeFit.bbToSaddleCentre, 111.803398874989485, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleAngle, 63.434948822922011, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleX, 50, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToSaddleY, 100, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleCentreToHand, 102.212724827891908, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.saddleToHandDrop, 23.39745962155614, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandX, 49.498743710661995, accuracy: 1e-13)
        XCTAssertEqual(bikeFit.bbToHandY, 76.602540378443865, accuracy: 1e-13)
    }
    
}
