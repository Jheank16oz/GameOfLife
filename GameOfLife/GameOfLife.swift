//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

internal class GameOfLife {

    
    
    let neighborCounter:NeighborCounter
    internal var cells:[[State]]
    
    init( cells: [[State]], neighborCounter: NeighborCounter){
        self.cells = cells
        self.neighborCounter = neighborCounter
    }
  
    func nextGeneration(){
        for (indexRow,cell) in cells.enumerated() {
            for (indexCol, _) in cell.enumerated() {
                evaluate(row: indexRow, col: indexCol)
            }
        }
    }

    func evaluate(row:Int, col:Int){
        let currentCell = Cell(row: row, col: col)
        let count = neighborCounter.numberOfNeighbors(of:currentCell,in:[[State]]())
        if count >= 0 {
            if isAlive(cell:currentCell) {
                if Rule.isUnderPopulation(count: count) {
                    die(cell:currentCell)
                }else if Rule.isBalanced(count: count) {
                    live(cell:currentCell)
                }else if Rule.isOverPopulation(count: count) {
                    die(cell:currentCell)
                }
            }else if isDead(cell:currentCell){
                if Rule.breed(count:count){
                    live(cell:currentCell)
                }
            }
        }
        
    }
    
    func isAlive(cell:Cell) -> Bool{
        let cell = cells[cell.row][cell.col]
        return cell == .alive
    }
    
    func isDead(cell:Cell) -> Bool{
        let cell = cells[cell.row][cell.col]
        return cell == .dead
    }
    
    func die(cell:Cell){
        cells[cell.row][cell.col] = .dead
    }
    
    func live(cell:Cell){
        cells[cell.row][cell.col] = .alive
    }
    
    struct Rule{
        static let underpopulation = 2
        static let balanced = 3
        static let overpopulation = 4
        static let breed = 3
        
        static func isUnderPopulation(count: Int) -> Bool{
            return count < underpopulation
        }
        
        static func isBalanced(count: Int) -> Bool{
            return count <= balanced
        }
        
        static func isOverPopulation(count: Int) -> Bool{
            return count >= overpopulation
        }
        
        static func breed(count: Int) -> Bool{
            return count == breed
        }
    }
    
}

public struct Cell:Equatable {
    let row:Int
    let col:Int
}


enum State{
    case dead
    case alive
}



