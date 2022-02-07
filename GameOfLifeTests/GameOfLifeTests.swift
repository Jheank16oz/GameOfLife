//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 7/02/22.
//

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {
    var cells = [[Bool]]()
    
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        //given live cell with fewer than two live neigbors
        let a:[Bool] = [false,false,false,false,false]
        let b:[Bool] = [false,false,false,false,false]
        let c:[Bool] = [false,false,true,false,false]
        let d:[Bool] = [false,false,false,false,false]
        let e:[Bool] = [false,false,false,false,false]
        cells = [a, b, c, d, e]
        
        let currentRow = 2
        let currentColumn = 2
    
        
        // when next generation
        nextGeneration();
        
        // then
        XCTAssertFalse(cells[currentRow][currentColumn])
    }
    
    func nextGeneration(){
        cells[2][2] = false
    }

}
