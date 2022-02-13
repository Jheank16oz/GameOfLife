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
        gameB.seed = .rpentomino5x5
        XCTAssertThrowsError(try gameB.build())
    }
    
    func test_build_notFailsIfGenerationsCountIsMoreThan0(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        gameB.seed = .rpentomino5x5
        XCTAssertNoThrow(try gameB.build())
    }
    
    func test_build_failsIfSeedIsNotConfigured(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        
        XCTAssertThrowsError(try gameB.build())
        
    }
    
    func test_start_startTicksWithGenerationCount(){
        let tick = TickSpy(game: nil, generation: nil, completion: {})
        let game = GameSpy(tick: tick)
        
        game.start()
        XCTAssertEqual(tick.startCalls, 1)
    }
    
    func test_oneTick_endToEnd(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        gameB.seed = .rpentomino5x5
        
        let exp = expectation(description: "wait first generation")
        gameB.update = { cells in
            XCTAssertEqual(cells, generateSeed(kind: .rpentomino2generation5x5))
            exp.fulfill()
        }
        do {
            let game = try gameB.build()
            game.start()
        } catch{
            XCTFail("unexpected failed")
        }
        
        wait(for: [exp], timeout: 20)
    }
    
    func test_oneTick_endToEndWithStrangeSeedShouldNotFail(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        gameB.seed = .strangeSeed
    
        do {
            let game = try gameB.build()
            XCTAssertNoThrow(game.start())
            
        } catch{
            XCTFail("unexpected failed")
        }
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
        super.init(game: GameOfLife(cells: [[State]](), neighborCounter: NeighborCounter(), update: { _ in}), generation: 10, completion: {})
    }
    
    override func start() {
        
        startCalls += 1
    }
}
