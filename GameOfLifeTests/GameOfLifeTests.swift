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
    var indexNextGeneration = (x: 0, y: 0)
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        //given live cell with fewer than two live neigbors
        generatePopulation()
        indexNextGeneration.x = 2
        indexNextGeneration.y = 2
    
        // when next generation
        nextGeneration();
        
        // then
        XCTAssertFalse(cells[indexNextGeneration.x][indexNextGeneration.y])
    }
    
    func nextGeneration(){
        cells[2][2] = false
    }
    
    func generatePopulation(){
        let a:[Bool] = [false,false,false,false,false]
        let b:[Bool] = [false,false,false,false,false]
        let c:[Bool] = [false,false,true,false,false]
        let d:[Bool] = [false,false,false,false,false]
        let e:[Bool] = [false,false,false,false,false]
        cells = [a, b, c, d, e]
    }

}
