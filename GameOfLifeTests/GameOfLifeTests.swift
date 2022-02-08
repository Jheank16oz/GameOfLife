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
        let game = GameOfLife(cells: generatePopulation())
        let states = [LiveNeighbours.zeroAlive, LiveNeighbours.oneAlive]
        
        
        let a:[Bool] = [false,false,false,false,false]
        let b:[Bool] = [false,false,false,false,false]
        let c:[Bool] = [false,false,false,false,false]
        let d:[Bool] = [false,false,false,false,false]
        let e:[Bool] = [false,false,false,false,false]
        
        let expected =  [a, b, c, d, e]
        
        for state in states {
            game.initialState(state: state)
            game.nextGeneration()
            XCTAssertEqual(game.cells, expected)
        }
        
        
        
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

enum LiveNeighbours {
    case zeroAlive
    case oneAlive
}
extension GameOfLife {
    
    func initialState(state:LiveNeighbours){
        switch state {
        case .zeroAlive:
            break
        case .oneAlive:
            cells[2][2] = true
            break
        default:
            break
        }
    }
}
