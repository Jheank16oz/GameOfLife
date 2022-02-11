//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

internal class GameOfLife {

    
    
    private let neighborCounter:NeighborCounter
    internal var cells:[[State]]
    let update:()->Void
    
    init(cells: [[State]], neighborCounter: NeighborCounter, update:@escaping ()->Void = { }){
        self.cells = cells
        self.neighborCounter = neighborCounter
        self.update = update
    }
  
    func nextGeneration(){
        for (indexRow,cell) in cells.enumerated() {
            for (indexCol, _) in cell.enumerated() {
                evaluate(row: indexRow, col: indexCol)
            }
        }
        update()
    }

    internal func evaluate(row:Int, col:Int){
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
    
    private func isAlive(cell:Cell) -> Bool{
        let cell = cells[cell.row][cell.col]
        return cell == .alive
    }
    
    private func isDead(cell:Cell) -> Bool{
        let cell = cells[cell.row][cell.col]
        return cell == .dead
    }
    
    internal func die(cell:Cell){
        cells[cell.row][cell.col] = .dead
    }
    
    internal func live(cell:Cell){
        cells[cell.row][cell.col] = .alive
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



