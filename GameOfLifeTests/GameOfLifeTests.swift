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
        let counterSpy = NeighboursCounterSpy()
        let liveGenerator = LiveGeneratorSpy(cells:cells, neighboursCounter:counterSpy)
        
        liveGenerator.nextGeneration()
        
        let expectedIndices = getExpectedIndicesFrom(cells: cells)
        let expectedCalls = expectedIndices.count
        
        XCTAssertEqual(liveGenerator.evaluations, expectedIndices)
        XCTAssertEqual(liveGenerator.evaluations.count, expectedCalls)
        XCTAssertEqual(counterSpy.neighBoursCalls, expectedCalls)
    }
    
    
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        
        let counterSpy = NeighboursCounterSpy()
        let oneNeighboursAlive = (row: 0, col: 2, count:1)
        let zeroNeighboursAlive = (row: 2, col: 2, count:0)
        
        counterSpy.setNeighboursCount(neighboursCount: [oneNeighboursAlive,zeroNeighboursAlive])
        let liveGenerator = LiveGeneratorSpy(cells:seedWith(type: .thereIsNotLife), neighboursCounter:counterSpy)
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.deathCellsCalled, [[0,2], [2,2]])
        
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
    var neighBoursCalls = 0
    var neighboursCount = [(row:Int,col:Int, count: Int)]()
    
    func setNeighboursCount(neighboursCount:[(row:Int,col:Int, count: Int)]){
        self.neighboursCount = neighboursCount
    }
    func neighboursCountAt(row:Int,col:Int) -> Int{
        neighBoursCalls += 1
        for neighboursCount in neighboursCount {
            if row == neighboursCount.row && col == neighboursCount.col {
                return neighboursCount.count
            }
        }
        return -1
    }
    
    
}

class LiveGeneratorSpy:LiveGenerator{
    
    var evaluations = [[Int]]()
    var deathCellsCalled = [[Int]]()
    
    override func evaluate(row: Int, col: Int) {
        super.evaluate(row: row, col: col)
        evaluations.append([row, col])
    }
    
    override func die(row: Int, col: Int) {
        deathCellsCalled.append([row, col])
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
