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
        gameB.seed = rpentomino()
        XCTAssertThrowsError(try gameB.build())
    }
    
    func test_build_notFailsIfGenerationsCountIsMoreThan0(){
        let gameB = GameOfLifeStarter.Builder()
        gameB.generationCount = 1
        gameB.seed = rpentomino()
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
        gameB.seed = rpentomino()
        
        let exp = expectation(description: "wait first generation")
        printSeed(seed: rpentomino())
        gameB.update = { cells in
            printSeed(seed: cells)
            printSeed(seed: rpentomino2Generation())
            XCTAssertEqual(cells, rpentomino2Generation())
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
    
    
}

func printSeed(seed:[[State]]){
        var value = ""
        for (_,row) in seed.enumerated() {
            var rowString = ""
            for (_,col) in row.enumerated() {
                //let state = col == State.alive ? "🕷" : "🕸"
                let state = col == State.alive ? "❤️" : "🤍"
                rowString += "\(state)"
            }
            value += "\(rowString)\n"
        }
        print("\(value)")
}
    
func rpentomino() -> [[State]]{

    return[
            [.dead, .dead, .dead, .dead],
            [.dead, .alive, .alive, .dead],
            [.alive, .alive, .dead, .dead],
            [.dead, .alive, .dead, .dead],
            [.dead, .dead, .dead, .dead]]
}

func rpentomino2Generation() -> [[State]]{

    return[
            [.dead, .dead, .dead, .dead],
            [.alive, .alive, .alive, .dead],
            [.alive, .dead, .dead, .dead],
            [.alive, .alive, .dead, .dead],
            [.dead, .dead, .dead, .dead]]
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
