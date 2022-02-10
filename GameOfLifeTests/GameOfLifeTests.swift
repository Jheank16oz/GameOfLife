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
        let counterSpy = NeighborCounterSpy()
        let liveGenerator = LiveGeneratorSpy(cells:cells, neighborCounter:counterSpy)
        
        liveGenerator.nextGeneration()
        
        let expectedIndices = getExpectedIndicesFrom(cells: cells)
        let expectedCalls = expectedIndices.count
        
        XCTAssertEqual(liveGenerator.evaluations, expectedIndices)
        XCTAssertEqual(liveGenerator.evaluations.count, expectedCalls)
        XCTAssertEqual(counterSpy.neighborCountCalls, expectedCalls)
    }
    
    
    func test_die_anyLiveCellWithFewerThanTwoLiveNeighborDies() {
        
        let alive1 = SpyCell(row: 0, col: 2, neighborCount:1, state: State.alive)
        let alive0 = SpyCell(row: 2, col: 2, neighborCount:0, state: State.alive)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [alive1, alive0])
        
        liveGenerator.nextGeneration()
        
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            alive1.asCell(),
            alive0.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive1.row, col: alive1.col), .dead)
        XCTAssertEqual(liveGenerator.getCell(row: alive0.row, col: alive0.col), .dead)
    }
    
    func test_live_anyLiveCellWithTwoOrThreeLiveNeighborLives() {
        
        
        let alive2 = SpyCell(row: 0, col: 2, neighborCount:2, state: State.alive)
        let alive3 = SpyCell(row: 2, col: 2, neighborCount:3, state: State.alive)
        
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
    
    func test_die_anyLiveCellWithMoreThanThreeLiveNeighborDies() {
        let alive4 = SpyCell(row: 0, col: 2, neighborCount:4, state: State.alive)
        let alive5 = SpyCell(row: 2, col: 2, neighborCount:5, state: State.alive)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [alive4, alive5])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.dieCellsCalled, [
            alive4.asCell(),
            alive5.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: alive4.row, col: alive4.col), .dead)
        XCTAssertEqual(liveGenerator.getCell(row: alive5.row, col: alive5.col), .dead)
    }
    
    func test_live_anyDeadCellWithThreeLiveBecomesALive() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighborCount:3, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [
            cellNC3.asCell()
        ])
        
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .alive)
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .alive)
    }
    
    func test_live_anyDeadCellWithFewerThanThreeLiveNeighborDontBecomesALive() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighborCount:2, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [])
        
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .dead)
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .dead)
    }
    
    func test_live_anyDeadCellWithMoreThanThreeLiveNeighborDontStayDeath() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighborCount:4, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [])
        
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .dead)
        XCTAssertEqual(liveGenerator.getCell(row: cellNC3.row, col: cellNC3.col), .dead)
    }
    
}


// Helpers
func makeLiveGenerator(initialCells:[SpyCell]) -> LiveGeneratorSpy{
    
    let counterSpy = NeighborCounterSpy()
    
    counterSpy.setNeighborCount(neighborCount: initialCells)
    
    let liveGenerator = LiveGeneratorSpy(cells:seedWith(type: .thereIsNotLife), neighborCounter:counterSpy)
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

class NeighborCounterSpy: NeighborCounter{
    var neighborCountCalls = 0
    var neighborCount = [SpyCell]()
    
    func setNeighborCount(neighborCount:[SpyCell]){
        self.neighborCount = neighborCount
    }
    
    func numberOfNeighbors(row:Int,col:Int) -> Int{
        neighborCountCalls += 1
        for neighborCount in neighborCount {
            if row == neighborCount.row && col == neighborCount.col {
                return neighborCount.neighborCount
            }
        }
        return -1
    }
    
    
}

struct SpyCell{
    let row:Int
    let col:Int
    let neighborCount:Int
    let state: State
    
    func asCell() ->Cell{
        return Cell(row: row, col: col)
    }
}

class LiveGeneratorSpy:LiveGenerator{
    
    var evaluations = [[Int]]()
    var dieCellsCalled = [Cell]()
    var liveCellsCalled = [Cell]()
    
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
            [.dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead]]
    }
    return [[]]
}
