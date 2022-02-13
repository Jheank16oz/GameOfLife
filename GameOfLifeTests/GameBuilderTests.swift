//
//  GameBuilderTests.swift
//  GameOfLifeTests
//
//  Created by jpineros on 13/02/22.
//

import Foundation
import XCTest
@testable import GameOfLife


class GameBuilderTest:XCTestCase{

    
    func test_build_failsIfGenerationsCountIsEmpty(){
        let gameB = GameOfLifeStarter.Builder()
        XCTAssertThrowsError(try gameB.build())
    }
    
    func test_build_notFailsIfGenerationsCountIsMoreThan0(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        XCTAssertNoThrow(try gameB.build())
    }
    
    func test_start_startTicksWithGenerationCount(){
        let tick = TickSpy(game: nil, generation: nil, completion: {})
        let game = GameSpy(tick: tick)
        
        game.start()
        XCTAssertEqual(tick.startCalls, 1)
    }
    
    
}

class GameSpy:GameOfLifeStarter{
    
    override init(tick:Tick) {
        super.init(tick: tick)
    }
    
    override func start() {
        super.start()
    }
}

class TickSpy:Tick{
    
    var startCalls = 0
    override init(game: GameOfLife?, generation: Int?, completion: @escaping () -> Void) {
        super.init(game: GameOfLife(cells: [[State]](), neighborCounter: NeighborCounter(), update: {}), generation: 10, completion: {})
    }
    
    override func start() {
        
        startCalls += 1
    }
}
