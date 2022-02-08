//
//  NeighboursCounter.swift
//  GameOfLife
//
//  Created by jpineros on 8/02/22.
//

import Foundation

import Foundation


protocol NeighboursCounter {
    
    func neighboursCountAt(row:Int,col:Int) -> Int
}
