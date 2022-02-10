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
        
        let alive1 = SpyCell(row: 0, col: 2, neighboursCount:1, state: State.alive)
        let alive0 = SpyCell(row: 2, col: 2, neighboursCount:0, state: State.alive)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [alive1, alive0])
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            alive1.asCell(),
            alive0.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive1.row, col: alive1.col), .death)
        XCTAssertEqual(liveGenerator.getCell(row: alive0.row, col: alive0.col), .death)
    }
    
    func test_live_anyLiveCellWithTwoOrThreeLiveNeighboursLives() {
        
        
        let alive2 = SpyCell(row: 0, col: 2, neighboursCount:2, state: State.alive)
        let alive3 = SpyCell(row: 2, col: 2, neighboursCount:3, state: State.alive)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [alive2, alive3])
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [
            alive2.asCell(),
            alive3.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive2.row, col: alive2.col), .alive)
        XCTAssertEqual(liveGenerator.getCell(row: alive3.row, col: alive3.col), .alive)
    }
    
    func test_die_anyLiveCellWithMoreThanThreeLiveNeighboursDies() {
        let alive4 = SpyCell(row: 0, col: 2, neighboursCount:4, state: State.alive)
        let alive5 = SpyCell(row: 2, col: 2, neighboursCount:5, state: State.alive)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [alive4, alive5])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            alive4.asCell(),
            alive5.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive4.row, col: alive4.col), .death)
        XCTAssertEqual(liveGenerator.getCell(row: alive5.row, col: alive5.col), .death)
    }
    
    func test_live_anyDeadCellWithThreeLiveBecomesALive() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighboursCount:3, state: State.death)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3])
        
        liveGenerator.nextGeneration()
        
       /* XCTAssertEqual(liveGenerator.liveCellsCalled, [
            [cellNC3.row,cellNC3.col]
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .alive)
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .alive)*/
    }
    
}


// Helpers
func makeLiveGenerator(initialCells:[SpyCell]) -> LiveGeneratorSpy{
    
    let counterSpy = NeighboursCounterSpy()
    
    counterSpy.setNeighboursCount(neighboursCount: initialCells)
    
    let liveGenerator = LiveGeneratorSpy(cells:seedWith(type: .thereIsNotLife), neighboursCounter:counterSpy)
    for cell in initialCells {
        liveGenerator.setCellState(row: cell.row, col: cell.col,state: cell.state)
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
    var neighboursCount = [SpyCell]()
    
    func setNeighboursCount(neighboursCount:[SpyCell]){
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

struct SpyCell{
    let row:Int
    let col:Int
    let neighboursCount:Int
    let state: State
    
    func asCell() ->Cell{
        return Cell(row: row, col: col)
    }
}

class LiveGeneratorSpy:LiveGenerator{
    
    var evaluations = [[Int]]()
    var dieCellsCalled = [Cell]()
    var liveCellsCalled = [Cell]()
    var liveCells = [[Int]]()
    
    override func evaluate(row: Int, col: Int) {
        super.evaluate(row: row, col: col)
        evaluations.append([row, col])
    }
    
    override func die(cell: Cell) {
        super.die(cell:cell)
        dieCellsCalled.append(cell)
    }
    
    override func live(cell: Cell) {
        super.live(cell: cell)
        liveCellsCalled.append(cell)
    }
    
    func getCell(row: Int, col: Int) -> State{
        print(cells)
        print("\n")
        return cells[row][col]
    }
    
    func setCellState(row: Int, col: Int, state:State) {
        cells[row][col] = state
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
