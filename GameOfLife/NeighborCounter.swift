//
//  NeighboursCounter.swift
//  GameOfLife
//
//  Created by jpineros on 8/02/22.
//

import Foundation

import Foundation


class NeighborCounter {
    
    
    
    func numberOfNeighbors(of cell:Cell,in cells:[[State]]) -> Int {
        if cells.isAnyRight(cell:cell) {
            return 1
        }
      return 0
    }
}

extension Array where Element == [State] {

    func isAnyRight(cell:Cell) -> Bool{
        return self[cell.row][cell.col+1] == State.alive
    }
}
