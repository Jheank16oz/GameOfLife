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

extension Array where Element == [State] {

    func isAnyLeft(cell:Cell) -> Bool{
        return self[cell.row][cell.col-1] == State.alive
    }
    
    func isAnyRight(cell:Cell) -> Bool{
        return self[cell.row][cell.col+1] == State.alive
    }
    
    func isAnyTop(cell:Cell) -> Bool{
        return self[cell.row-1][cell.col] == State.alive
    }
    
    func isAnyBottom(cell:Cell) -> Bool{
        return self[cell.row+1][cell.col] == State.alive
    }
    
    func isAnyTopRight(cell:Cell) -> Bool{
        return self[cell.row-1][cell.col+1] == State.alive
    }
    
    func isAnyBottomRight(cell:Cell) -> Bool{
        return self[cell.row+1][cell.col+1] == State.alive
    }
    
    func isAnyTopLeft(cell:Cell) -> Bool{
        return self[cell.row-1][cell.col-1] == State.alive
    }
    
    func isAnyBottomLeft(cell:Cell) -> Bool{
        return self[cell.row+1][cell.col-1] == State.alive
    }
}
