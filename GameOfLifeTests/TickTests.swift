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


    func test_tick_everyTickCallNextGeneration(){
        let exp = expectation(description: "Expect ticks count")
        
        let game = GameOfLifeSpy(cells: [[]], neighborCounter: NeighborCounter(), update: { _ in})
        Tick(game: game, generation: 10, completion: {
            
            XCTAssertEqual(game.nextGenerationCalls, 10)
            
            exp.fulfill()
             
        }).start()
        wait(for: [exp], timeout: 20.0)
    }
    
    
    
    class GameOfLifeSpy:GameOfLife{
        var nextGenerationCalls = 0
        override func nextGeneration() {
            nextGenerationCalls += 1
        }
    }
    
    
}
