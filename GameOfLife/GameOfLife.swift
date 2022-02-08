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
                if cell {
                    let neighbourTop = cells[rowIndex - 1][columnIndex]
                    let neighbourDown = cells[rowIndex + 1][columnIndex]
                    let neighbourLeft = cells[rowIndex][columnIndex - 1]
                    let neighbourRight = cells[rowIndex][columnIndex + 1]
                    let neighbourTopLeft = cells[rowIndex - 1][columnIndex - 1]
                    let neighbourTopRight = cells[rowIndex - 1][columnIndex + 1]
                    let neighbourDownLeft = cells[rowIndex + 1 ][columnIndex - 1]
                    let neighbourDownRight = cells[rowIndex + 1 ][columnIndex + 1]
                    
                    let count = sum(neighBours: neighbourTop, neighbourDown, neighbourLeft, neighbourRight, neighbourTopLeft, neighbourTopRight, neighbourDownLeft, neighbourDownRight)
                    
                    if count < 2 {
                        cells[rowIndex][columnIndex] = false
                    }
                }
                    
            }
                
        }
    }
    
    func sum(neighBours:Bool...) -> Int{
        var sum: Int = 0
        for n in neighBours {
            if n {  sum += 1}
        }
        return sum
    }
}
