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
        let game = GameOfLife(cells: thereIsNoLife)
        let states = [
            LiveNeighbours.zeroAlive,
            LiveNeighbours.oneAliveTop,
            LiveNeighbours.oneAliveDown,
            LiveNeighbours.oneAliveLeft,
            LiveNeighbours.oneAliveRight,
            LiveNeighbours.oneAliveTopRight,
            LiveNeighbours.oneAliveTopLeft,
            LiveNeighbours.oneAliveDownRight,
            LiveNeighbours.oneAliveDownLeft,
        ]
        
        for state in states {
            game.initialState(state: state)
            print(game.cells)
            print("\n")
            game.nextGeneration()
            XCTAssertEqual(game.cells, thereIsNoLife)
            game.extermination()
        }
    }
    
    
    
    
    
}

enum LiveNeighbours {
    case zeroAlive
    case oneAliveTop
    case oneAliveDown
    case oneAliveLeft
    case oneAliveRight
    case oneAliveTopRight
    case oneAliveTopLeft
    case oneAliveDownRight
    case oneAliveDownLeft
}
extension GameOfLife {
    
    func initialState(state:LiveNeighbours){
        cells[2][2] = true
        
        switch state {
        case .zeroAlive:
            break
        case .oneAliveTop:
            cells[1][2] = true
            break
        case .oneAliveDown:
            cells[3][2] = true
            break
        case .oneAliveLeft:
            cells[2][1] = true
            break
        case .oneAliveRight:
            cells[2][3] = true
            break
        case .oneAliveTopRight:
            cells[1][3] = true
            break
        case .oneAliveTopLeft:
            cells[1][1] = true
            break
        case .oneAliveDownRight:
            cells[3][1] = true
            break
        case .oneAliveDownLeft:
            cells[3][3] = true
            break
        }
    }
    
    func extermination(){
        cells = thereIsNoLife
    }
}

    

let a:[Bool] = [false,false,false,false,false]
let b:[Bool] = [false,false,false,false,false]
let c:[Bool] = [false,false,false,false,false]
let d:[Bool] = [false,false,false,false,false]
let e:[Bool] = [false,false,false,false,false]

let thereIsNoLife =  [a, b, c, d, e]
