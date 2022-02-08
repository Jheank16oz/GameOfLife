//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 7/02/22.
//

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {
    
    
    
    
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        
        //given a live cell
        let cell = seedWith(type:.liveCellWithFewerThanTwoLiveNeighbours)
        let liveGenerator = LiveGenerator(cells:cell.cells)
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.getCellAt(cell.cellPosition), State.death)
        
    }
    
    
    
    
    
    
    
    
}

class LiveGeneratorSpy:LiveGenerator{
    
    var cellDeathCalled = 0
    
}

enum HelperSeedType{
    case liveCellWithFewerThanTwoLiveNeighbours
}
    
func seedWith(type: HelperSeedType) -> (cells: [[State]], cellPosition:(row: Int, col: Int)){
    
    switch type{
    case .liveCellWithFewerThanTwoLiveNeighbours:
        return (
            cells: [
            [.death, .death, .death, .death],
            [.death, .death, .death, .death],
            [.death, .alive, .death, .death],
            [.death, .death, .death, .death],
            [.death, .death, .death, .death]],
            cellPosition:(row: 2, col: 2))
    default:
        return (cells: [[]], cellPosition:(row: 0, col: 0))
    }
}
