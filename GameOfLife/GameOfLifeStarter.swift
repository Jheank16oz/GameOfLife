//
//  GameBuilder.swift
//  GameOfLife
//
//  Created by jpineros on 13/02/22.
//

import Foundation

public class GameOfLifeStarter {

    let tick:Tick
    init(tick:Tick){
        self.tick = tick
    }
    
    public func start(){
        tick.start()
    }
    
    public class Builder {
        public var generationCount = 0
        public var seed:KindSeed?
        public var update:([[State]])->Void = {_ in}
        public init(){
        
        }
        
        public func build()  throws -> GameOfLifeStarter{
            if generationCount <= 0 {
                throw BuildError(kind: .generationsNotConfiguredOrLowerThanZero)
            }
            
            if seed == nil {
                throw BuildError(kind: .seedNotConfigured)
            }
            
            let generatedCells = generateSeed(kind:seed ?? KindSeed.rpentomino20x20)
            let gameOfLife = GameOfLife(cells: generatedCells, neighborCounter: NeighborCounter(), update: update)
            let tick = Tick(game: gameOfLife, generation: generationCount, completion: {})
            return GameOfLifeStarter(tick: tick)
        }
    }

    

}

public struct BuildError: Error {
    public enum ErrorKind {
        case generationsNotConfiguredOrLowerThanZero
        case seedNotConfigured
    }
    let kind: ErrorKind
         
}
