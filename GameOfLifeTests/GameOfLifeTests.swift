//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 7/02/22.
//

import XCTest
@testable import GameOfLife

class GameOfLifeTests: XCTestCase {
    
    
    
    
    func test_dies_anyLiveCellWithFewerThanTwoLiveNeighboursDies() {
        //given live cell with fewer than two live neigbors
        let game = GameOfLife(cells: [[]])
        
        let neighbourStates = [ LiveNeighbors.zeroAlive, LiveNeighbors.oneAlive]
        
        
        
            
        
    }
    
    
    
    func generatePopulation() ->[[Bool]]{
        let a:[Bool] = [false,false,false,false,false]
        let b:[Bool] = [false,false,false,false,false]
        let c:[Bool] = [false,false,false,false,false]
        let d:[Bool] = [false,false,false,false,false]
        let e:[Bool] = [false,false,false,false,false]
        return [a, b, c, d, e]
    }
}

enum LiveNeighbors {
    case zeroAlive
    case oneAlive
}
