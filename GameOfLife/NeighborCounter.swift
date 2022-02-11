//
//  NeighboursCounter.swift
//  GameOfLife
//
//  Created by jpineros on 8/02/22.
//

import Foundation

import Foundation


internal class NeighborCounter {
    
    
    
    func numberOfNeighbors(of cell:Cell,in cells:[[State]]) -> Int {
        var count = 0
        
        if cells.isAnyRight(cell:cell) {
            count += 1
        }
        if cells.isAnyLeft(cell:cell) {
            count += 1
        }
        if cells.isAnyTop(cell:cell) {
            count += 1
        }
        if cells.isAnyBottom(cell:cell) {
            count += 1
        }
        if cells.isAnyTopRight(cell:cell) {
            count += 1
        }
        if cells.isAnyTopLeft(cell:cell) {
            count += 1
        }
        if cells.isAnyBottomLeft(cell:cell) {
            count += 1
        }
        if cells.isAnyBottomRight(cell:cell) {
            count += 1
        }
      return count
    }
}

private extension Array where Element == [State] {

    func isAnyLeft(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row, cell.col-1))
    }
    
    func isAnyRight(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row,cell.col+1))
    }
    
    func isAnyTop(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row-1,cell.col))
    }
    
    func isAnyBottom(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row+1,cell.col))
    }
    
    func isAnyTopRight(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row-1,cell.col+1))
    }
    
    func isAnyBottomRight(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row+1,cell.col+1))
    }
    
    func isAnyTopLeft(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row-1,cell.col-1))
    }
    
    func isAnyBottomLeft(cell:Cell) -> Bool{
        return isAlive(cell: (cell.row+1,cell.col-1))
    }
    
    func isAlive(cell:(Int,Int)) -> Bool{
        if self.indices.contains(cell.0){
            if self[cell.0].indices.contains(cell.1){
                return self[cell.0][cell.1] == State.alive
            }
        }
        return false
    }
}
