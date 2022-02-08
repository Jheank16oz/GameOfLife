//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

internal class LiveGenerator {
    
    let neighboursCounter:NeighboursCounter
    let cells:[[State]]
    let cellIndex = 0
    
    init( cells: [[State]], neighboursCounter: NeighboursCounter){
        self.cells = cells
        self.neighboursCounter = neighboursCounter
    }
  
    func nextGeneration(){
        for (indexRow,cell) in cells.enumerated() {
            for (indexCol, _) in cell.enumerated() {
                evaluate(row: indexRow, col: indexCol)
            }
        }
    }
    
    func evaluate(row:Int, col:Int){
        let count = neighboursCounter.neighboursOf(row:row,col:col)
        if count >= 0 {
            if count < 2 {
                die(row: row, col: col)
            }
        }
        
    }
    
    func die(row: Int, col: Int){
        
    }
    
}


enum State{
    case death
    case alive
}
