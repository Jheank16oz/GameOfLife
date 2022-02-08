//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by jpineros on 7/02/22.
//

import Foundation

internal class LiveGenerator {
    
    init( cells: [[State]]){
        
    }
  
    func nextGeneration(){
        
    }
    
    func getCellAt(_:(row: Int, col: Int)) -> State {
        return .death
    }
}


enum State{
    case death
    case alive
}
