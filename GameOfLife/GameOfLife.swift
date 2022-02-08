//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

final class GameOfLife {
    var cells:[[Bool]]
    
    init(cells:[[Bool]]){
        self.cells = cells
    }
         
    func nextGeneration(){
        
        for (rowIndex, rows) in cells.enumerated() {
            for (columnIndex, cell) in rows.enumerated() {
                if cell == true {
                    cells[rowIndex][columnIndex] = false
                }
                    
            }
                
        }
    }
}
