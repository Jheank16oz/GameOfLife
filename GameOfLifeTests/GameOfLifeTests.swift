//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 7/02/22.
//

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {
    
    func test_nextGeneration_everyCellShouldBeIterated(){
        let cells = seedWith(type: .thereIsNotLife)
        let liveGenerator = LiveGeneratorSpy(cells:cells, neighboursCounter:NeighboursCounterSpy())
        
        liveGenerator.nextGeneration()
        
        let expectedIndices = getExpectedIndicesFrom(cells: cells)
        let expectedCalls = expectedIndices.count
        
        XCTAssertEqual(liveGenerator.evaluations, expectedIndices)
        XCTAssertEqual(liveGenerator.evaluations.count, expectedCalls)
    }
    
    
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        
        //given a live cell
        //let cell = seedWith(type:.liveCellWithFewerThanTwoLiveNeighbours)
        let liveGenerator = LiveGeneratorSpy(cells:[[]], neighboursCounter:NeighboursCounterSpy())
        
        
        liveGenerator.nextGeneration()
        
        //XCTAssertTrue(liveGenerator.cellDeathCalled)
        
    }
    
    
    
    
    
    
    
    
}

func getExpectedIndicesFrom(cells:[[State]]) -> [[Int]]{
    var expectedIndices = [[Int]]()
    for (indexCell,cell) in cells.enumerated() {
        for (indexRow, _) in cell.enumerated() {
            expectedIndices.append([indexCell,indexRow])
        }
    }
    
    return expectedIndices
}

class NeighboursCounterSpy: NeighboursCounter{
    
    
}

class LiveGeneratorSpy:LiveGenerator{
    
    var evaluations = [[Int]]()
    
    override func evaluate(row: Int, col: Int) {
        evaluations.append([row, col])
    }
    
}

enum HelperSeedType{
    case thereIsNotLife
}
    
func seedWith(type: HelperSeedType) -> [[State]]{
    
    switch type{
    case .thereIsNotLife:
        return[
            [.death, .death, .death, .death],
            [.death, .death, .death, .death],
            [.death, .death, .death, .death],
            [.death, .death, .death, .death],
            [.death, .death, .death, .death]]
    default:
        return [[]]
    }
}
