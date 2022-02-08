//
//  NeighboursCounter.swift
//  GameOfLife
//
//  Created by jpineros on 8/02/22.
//

import Foundation

import Foundation


protocol NeighboursCounter {
    
    func neighboursOf(row:Int,col:Int) -> Int
}
