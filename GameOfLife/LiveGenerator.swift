//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

internal class LiveGenerator {
    
    let neighboursCounter:NeighboursCounter
    internal var cells:[[State]]
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
        let count = neighboursCounter.neighboursCountAt(row:row,col:col)
        if count >= 0 {
            if cells[row][col] == .alive{
                if count < Rule.underpopulation {
                    die(row: row, col: col)
                }else if count <= Rule.balanced {
                    live(row: row, col: col)
                }else if count >= Rule.overpopulation {
                    die(row: row, col: col)
                }
            }
            
        }
        
    }
    
    func die(row: Int, col: Int){
        cells[row][col] = .death
    }
    
    func live(row: Int, col: Int){
        cells[row][col] = .alive
    }
    
    struct Rule{
        static let underpopulation = 2
        static let balanced = 3
        static let overpopulation = 4
    }
    
}


enum State{
    case death
    case alive
}



