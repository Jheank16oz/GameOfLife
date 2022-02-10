//
//  NeighboursCounter.swift
//  GameOfLife
//
//  Created by jpineros on 8/02/22.
//

import Foundation

import Foundation


protocol NeighborCounter {
    
    func numberOfNeighbors(row:Int,col:Int) -> Int
}
