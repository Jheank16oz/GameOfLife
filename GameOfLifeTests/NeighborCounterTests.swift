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
        
        for seed in Seed.generate(at:referenceCell, neighborCount:0){
            let count = counter.numberOfNeighbors(of:referenceCell,in: seed)
            XCTAssertEqual(count, 0)
        }
        
    }
    
    func test_numberOfNeighbors_anyCellWithOneNeighborReturnOne() {
        let counter = NeighborCounter()
        let seeds = Seed.generate(at:referenceCell, neighborCount:1)
        for seed in seeds{
            let count = counter.numberOfNeighbors(of:referenceCell,in: seed)
            XCTAssertEqual(count, 1)
        }
    }
    
}

// Helpers

final class Seed {
    static func generate(at cell:Cell,neighborCount:Int) -> [[[State]]]{
        
        let cells:[[State]] = [
        [.dead, .dead, .dead],
        [.dead, .dead, .dead],
        [.dead, .alive, .dead],
        [.dead, .dead, .dead],
        [.dead, .dead, .dead]]
        
        let cLeft = Cell(row: 2, col: 0)
        let cRight = Cell(row: 2, col: 2)
        let cTop = Cell(row: 1, col: 1)
        let cBottom = Cell(row: 3, col: 1)
        let cLeftTop = Cell(row: 1, col: 0)
        let cLeftBottom = Cell(row: 3, col: 0)
        let cRightTop = Cell(row: 1, col: 2)
        let cRightBottom = Cell(row: 3, col: 2)
        
        let neighborCellsSet = [cLeft, cRight, cTop, cBottom, cLeftTop, cLeftBottom, cRightTop, cRightBottom]
        let sets = powerSet(set:neighborCellsSet).filter{ $0.count == neighborCount}
        var seeds = [[[State]]]()
        
        for cset in sets {
            var currentSeed = cells
            currentSeed.setAlive(aliveCells: cset)
            seeds.append(currentSeed)
            printSeed(seed:currentSeed)
        }
        
        return seeds
    }
    
    static func printSeed(seed:[[State]]){
        var value = ""
        for (index,row) in seed.enumerated() {
            var rowString = ""
            for (indexCol,col) in row.enumerated() {
                //let state = col == State.alive ? "🕷" : "🕸"
                let state = col == State.alive ? "❤️" : "🤍"
                rowString += "\(state)"
            }
            value += "\(rowString)\n"
        }
        print("\(value)")
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

private extension Array where Element == [State] {

    mutating func setAlive(aliveCells:[Cell]){
       for aliveCell in aliveCells {
           self[aliveCell.row][aliveCell.col] = State.alive
       }
    }
}
