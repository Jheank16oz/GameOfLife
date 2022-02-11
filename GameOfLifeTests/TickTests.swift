//
//  TickTest.swift
//  GameOfLife
//
//  Created by jpineros on 11/02/22.
//

import Foundation
import XCTest
@testable import GameOfLife

class TickTests: XCTestCase {


    func test_tick_everySecond(){
        let life = GameOfLife(cells: [[State]](), neighborCounter: NeighborCounter())
        let tick = Tick()
        tick.start {
        
        }
        
    
    }
    
    
    
}
