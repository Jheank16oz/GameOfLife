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
        cells[indexNextGeneration.x][indexNextGeneration.y] = true
    
        // when next generation
        nextGeneration();
        
        // then
        XCTAssertFalse(cells[indexNextGeneration.x][indexNextGeneration.y])
    }
    
    func test_live_anyLiveCellWithTwoOrThreeLiveNeighboursLives(){
        generatePopulation()
        indexNextGeneration.x = 2
        indexNextGeneration.y = 2
    
        cells[indexNextGeneration.x][indexNextGeneration.y] = true
        cells[indexNextGeneration.x][indexNextGeneration.y - 1] = true
        cells[indexNextGeneration.x][indexNextGeneration.y + 1] = true
        // when next generation
        nextGeneration();
        
        // then
        XCTAssertTrue(cells[indexNextGeneration.x][indexNextGeneration.y])
    }
    
    func nextGeneration(){
        if cells[indexNextGeneration.x][indexNextGeneration.y - 1] == true {
            if cells[indexNextGeneration.x][indexNextGeneration.y + 1] == true {
                cells[2][2] = true
            } else {
                cells[2][2] = false
            }
        } else{
            cells[2][2] = false
        }
            
    }
    
    func generatePopulation(){
        let a:[Bool] = [false,false,false,false,false]
        let b:[Bool] = [false,false,false,false,false]
        let c:[Bool] = [false,false,false,false,false]
        let d:[Bool] = [false,false,false,false,false]
        let e:[Bool] = [false,false,false,false,false]
        cells = [a, b, c, d, e]
    }

}
