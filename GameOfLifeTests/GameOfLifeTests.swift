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
    
    
    func test_die_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        
        let cells = seedWith(type: .thereIsNotLife)
        let counterSpy = NeighboursCounterSpy()
        let alive1 = (row: 0, col: 2, count:1)
        let alive0 = (row: 2, col: 2, count:0)
        counterSpy.setNeighboursCount(neighboursCount: [alive1,alive0])
        
        
        let liveGenerator = LiveGeneratorSpy(cells:cells, neighboursCounter:counterSpy)
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            [alive1.row,alive1.col],
            [alive0.row,alive0.col]
        ])
        
        XCTAssertEqual(cells[alive1.row][ alive1.col], .death)
        XCTAssertEqual(cells[alive0.row][ alive0.col], .death)
    }
    
    func test_live_anyLiveCellWithTwoOrThreeLiveNeighboursLives() {
        
        let cells = seedWith(type: .thereIsNotLife)
        let counterSpy = NeighboursCounterSpy()
        let alive2 = (row: 0, col: 2, count:2)
        let alive3 = (row: 2, col: 2, count:3)
        counterSpy.setNeighboursCount(neighboursCount: [alive2,alive3])
        
        
        let liveGenerator = LiveGeneratorSpy(cells:cells, neighboursCounter:counterSpy)
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [
            [alive2.row,alive2.col],
            [alive3.row,alive3.col]
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive2.row, col: alive2.col), .alive)
        XCTAssertEqual(liveGenerator.getCell(row: alive3.row, col: alive3.col), .alive)
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
    var dieCellsCalled = [[Int]]()
    var liveCellsCalled = [[Int]]()
    
    override func evaluate(row: Int, col: Int) {
        super.evaluate(row: row, col: col)
        evaluations.append([row, col])
    }
    
    override func die(row: Int, col: Int) {
        dieCellsCalled.append([row, col])
    }
    
    override func live(row: Int, col: Int) {
        super.live(row: row, col: col)
        liveCellsCalled.append([row, col])
    }
    
    func getCell(row: Int, col: Int) -> State{
        return self.cells[row][col]
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
