//
//  NeighbourCounterTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 10/02/22.
//

import Foundation

import XCTest
@testable import GameOfLife

class NeighborCounterTests: XCTestCase {

    let referenceCell = Cell(row: 2, col: 1)
    func test_numberOfNeighbors_anyCellWithZeroNeighborReturnZero() {
        let neighborCount = 0
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
        
    }
    
    func test_numberOfNeighbors_anyCellWithOneNeighborReturnOne() {
        let neighborCount = 1
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
    }
    
    func test_numberOfNeighbors_anyCellWithTwoNeighborReturnTwo() {
        let neighborCount = 2
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
        
    }
    
    func test_numberOfNeighbors_anyCellWithThreeNeighborReturnThree() {
        let neighborCount = 3
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
    }
    
    func test_numberOfNeighbors_anyCellWithFourNeighborReturnFour() {
        let neighborCount = 4
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
        
    }
    
    func test_numberOfNeighbors_anyCellWithFiveNeighborReturnFive() {
        let neighborCount = 5
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
    }
    
    func test_numberOfNeighbors_anyCellWithSixNeighborReturnSix() {
        let neighborCount = 6
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
        
    }
    
    func test_numberOfNeighbors_anyCellWithSevenNeighborReturnSeven() {
        let neighborCount = 7
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
    }
    
    func test_numberOfNeighbors_anyCellWithEightNeighborReturnEight() {
        let neighborCount = 8
        let powerSeed = makePowerSeed(with: neighborCount)
        assertCount(powerSeed: powerSeed, count: neighborCount)
        
    }
    
    
    
    func assertCount(powerSeed s:(counter:NeighborCounter, seeds:[[[State]]]), count:Int, file: StaticString = #filePath, line: UInt = #line){
        for seed in s.seeds{
            let count = s.counter.numberOfNeighbors(of:referenceCell,in: seed)
            XCTAssertEqual(count, count, file: file, line: line)
        }
    }
    
    func makePowerSeed(with neighborCount: Int) -> (counter:NeighborCounter, seeds:[[[State]]]) {
        let counter = NeighborCounter()
        let seeds = Seed.generate(at:referenceCell, neighborCount:neighborCount)
        return (counter, seeds)
    }
    
}

// Helpers

final class Seed {
    static func generate(at cell:Cell,neighborCount:Int) -> [[[State]]]{
        let sets = setsOf(count:neighborCount)
        var seeds = [[[State]]]()
        
        for cset in sets {
            var currentSeed = emptySeed
            currentSeed.setAlive(aliveCells: cset)
            seeds.append(currentSeed)
        }
        
        return seeds
    }
    
    static func setsOf(count:Int) -> [[Cell]]{
        let cLeft = Cell(row: 2, col: 0)
        let cRight = Cell(row: 2, col: 2)
        let cTop = Cell(row: 1, col: 1)
        let cBottom = Cell(row: 3, col: 1)
        let cLeftTop = Cell(row: 1, col: 0)
        let cLeftBottom = Cell(row: 3, col: 0)
        let cRightTop = Cell(row: 1, col: 2)
        let cRightBottom = Cell(row: 3, col: 2)
        
        let neighborCellsSet = [cLeft, cRight, cTop, cBottom, cLeftTop, cLeftBottom, cRightTop, cRightBottom]
        return powerSet(set:neighborCellsSet).filter{ $0.count == count}
    }
    
    
    //A Power Set is a set of all the subsets of a set
    //https://www.mathsisfun.com/sets/power-set.html
    static func powerSet(set:[Cell]) ->[[Cell]]{
        var powerSet:[[Cell]] = [[]]
        var flag:[Cell]  = [Cell]()
        
        for indexCells in 0...set.count - 1{
            for indexPowerSet in 0...powerSet.count - 1 {
                flag = powerSet[indexPowerSet]
                flag.append(set[indexCells])
                powerSet.append(flag)
            }
        }
        return powerSet
    }
    
    static let emptySeed:[[State]] = [
        [.dead, .dead, .dead],
        [.dead, .dead, .dead],
        [.dead, .alive, .dead],
        [.dead, .dead, .dead],
        [.dead, .dead, .dead]]
        
}

private extension Array where Element == [State] {

    mutating func setAlive(aliveCells:[Cell]){
       for aliveCell in aliveCells {
           self[aliveCell.row][aliveCell.col] = State.alive
       }
    }
}
