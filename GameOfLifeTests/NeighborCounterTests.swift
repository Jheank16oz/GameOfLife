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
        let counter = NeighborCounter()
        let count = counter.numberOfNeighbors(of:referenceCell,in: Seed.generate(at:referenceCell, neighborCount:0))
        
        XCTAssertEqual(count, 0)
    }
    
    func test_numberOfNeighbors_anyCellWithOneNeighborReturnOne() {
        let counter = NeighborCounter()
        let count = counter.numberOfNeighbors(of:referenceCell,in:Seed.generate(at:referenceCell, neighborCount:1))
        
        XCTAssertEqual(count, 1)
    }
    
}

final class Seed {
    static func generate(at cell:Cell,neighborCount:Int) -> [[State]]{
        
        let cells:[[State]] = [
        [.dead, .dead, .dead],
        [.dead, .dead, .dead],
        [.dead, .alive, .dead],
        [.dead, .dead, .dead],
        [.dead, .dead, .dead]]
        
        if neighborCount == 0 {
            return cells
        }
        
        let cLeft = Cell(row: 2, col: 0)
        let cRight = Cell(row: 2, col: 2)
        let cTop = Cell(row: 1, col: 1)
        let cBottom = Cell(row: 3, col: 1)
        let cLeftTop = Cell(row: 1, col: 0)
        let cLeftBottom = Cell(row: 3, col: 0)
        let cRightTop = Cell(row: 1, col: 2)
        let cRightBottom = Cell(row: 3, col: 2)
        
        let neighborCellsSet = [cLeft, cRight, cTop, cBottom, cLeftTop, cLeftBottom, cRightTop, cRightBottom]
        print(powerSet(set:neighborCellsSet))
        
        
        
        return cells
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
}
