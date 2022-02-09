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
        
        let alive1 = (row: 0, col: 2, neighboursCount:1)
        let alive0 = (row: 2, col: 2, neighboursCount:0)
        
        let liveGenerator = makeLiveGenerator(
            liveCells: [alive1, alive0])
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            [alive1.row,alive1.col],
            [alive0.row,alive0.col]
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive1.row, col: alive1.col), .death)
        XCTAssertEqual(liveGenerator.getCell(row: alive0.row, col: alive0.col), .death)
    }
    
    func test_live_anyLiveCellWithTwoOrThreeLiveNeighboursLives() {
        
        
        let alive2 = (row: 0, col: 2, neighboursCount:2)
        let alive3 = (row: 2, col: 2, neighboursCount:3)
        
        let liveGenerator = makeLiveGenerator(
            liveCells: [alive2, alive3])
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [
            [alive2.row,alive2.col],
            [alive3.row,alive3.col]
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive2.row, col: alive2.col), .alive)
        XCTAssertEqual(liveGenerator.getCell(row: alive3.row, col: alive3.col), .alive)
    }
    
    func test_die_anyLiveCellWithMoreThanThreeLiveNeighboursDies() {
        let alive4 = (row: 0, col: 2, neighboursCount:4)
        let alive5 = (row: 2, col: 2, neighboursCount:5)
        
        let liveGenerator = makeLiveGenerator(
            liveCells: [alive4, alive5])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            [alive4.row,alive4.col],
            [alive5.row,alive5.col]
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive4.row, col: alive4.col), .death)
        XCTAssertEqual(liveGenerator.getCell(row: alive5.row, col: alive5.col), .death)
    }
    
}

func makeLiveGenerator(liveCells:[(row: Int, col: Int, neighboursCount: Int)]) -> LiveGeneratorSpy{
    
    let counterSpy = NeighboursCounterSpy()
    
    counterSpy.setNeighboursCount(neighboursCount: liveCells)
    
    let liveGenerator = LiveGeneratorSpy(cells:seedWith(type: .thereIsNotLife), neighboursCounter:counterSpy)
    for liveCell in liveCells {
        liveGenerator.setLiveCell(row: liveCell.row, col: liveCell.col)
    }

    return liveGenerator
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
    var neighboursCount = [(row:Int, col:Int, neighboursCount: Int)]()
    
    func setNeighboursCount(neighboursCount:[(row:Int,col:Int, neighboursCount: Int)]){
        self.neighboursCount = neighboursCount
    }
    
    func neighboursCountAt(row:Int,col:Int) -> Int{
        neighBoursCalls += 1
        for neighboursCount in neighboursCount {
            if row == neighboursCount.row && col == neighboursCount.col {
                return neighboursCount.neighboursCount
            }
        }
        return -1
    }
    
    
}

class LiveGeneratorSpy:LiveGenerator{
    
    var evaluations = [[Int]]()
    var dieCellsCalled = [[Int]]()
    var liveCellsCalled = [[Int]]()
    var liveCells = [[Int]]()
    
    override func evaluate(row: Int, col: Int) {
        super.evaluate(row: row, col: col)
        evaluations.append([row, col])
    }
    
    override func die(row: Int, col: Int) {
        super.die(row: row, col: col)
        dieCellsCalled.append([row, col])
    }
    
    override func live(row: Int, col: Int) {
        super.live(row: row, col: col)
        liveCellsCalled.append([row, col])
    }
    
    func getCell(row: Int, col: Int) -> State{
        print(cells)
        print("\n")
        return cells[row][col]
    }
    
    func setLiveCell(row: Int, col: Int) {
        cells[row][col] = .alive
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
    }
    return [[]]
}
