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
        
        assert(areWith: .dead, liveGenerator: liveGenerator, cells: [alive1, alive0])
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
        
        assert(areWith: .alive, liveGenerator: liveGenerator, cells: [alive2, alive3])
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
        
        assert(areWith: .dead, liveGenerator: liveGenerator, cells: [alive4, alive5])
    }
    
    func test_live_anyDeadCellWithThreeLiveBecomesALive() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighborCount:3, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [
            cellNC3.asCell()
        ])
        
        assert(areWith: .alive, liveGenerator: liveGenerator, cells: [cellNC3])
    }
    
    func test_live_anyDeadCellWithFewerThanThreeLiveNeighborDontBecomesALive() {
        let cellNC3 = SpyCell(row: 0, col: 2, neighborCount:2, state: State.dead)
        let cellNC1 = SpyCell(row: 1, col: 1, neighborCount:1, state: State.dead)
        let cellNC0 = SpyCell(row: 2, col: 2, neighborCount:0, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC3, cellNC1, cellNC0])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [])
        assert(areWith: .dead, liveGenerator: liveGenerator, cells: [cellNC3, cellNC1, cellNC0])
    }
    
    func test_live_anyDeadCellWithMoreThanThreeLiveNeighborStayDeath() {
        let cellNC4 = SpyCell(row: 0, col: 2, neighborCount:4, state: State.dead)
        let cellNC5 = SpyCell(row: 1, col: 1, neighborCount:5, state: State.dead)
        let cellNC6 = SpyCell(row: 2, col: 2, neighborCount:6, state: State.dead)
        
        let liveGenerator = makeLiveGenerator(
            initialCells: [cellNC4, cellNC5,cellNC6])
        
        liveGenerator.nextGeneration()
        
        XCTAssertEqual(liveGenerator.liveCellsCalled, [])
        
        assert(areWith: .dead, liveGenerator: liveGenerator, cells: [cellNC4, cellNC5, cellNC6])
    }
    
}


// Helpers

func assert(areWith state:State, liveGenerator:LiveGeneratorSpy, cells:[SpyCell], file: StaticString = #filePath, line: UInt = #line){
    for cell in cells {
        XCTAssertEqual(liveGenerator.getCell(row: cell.row, col: cell.col), state, file: file, line: line)
    }
}

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
