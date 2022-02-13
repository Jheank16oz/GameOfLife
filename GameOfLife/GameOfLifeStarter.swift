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
        public init(){
        
        }
        
        public func build()  throws -> GameOfLifeStarter{
            if generationCount <= 0 {
                throw BuildError(kind: .generationsNotConfiguredOrLowerThanZero)
            }
            let gameOfLife = GameOfLife(cells: [[State]](), neighborCounter: NeighborCounter(), update: {
            
            })
            let tick = Tick(game: gameOfLife, generation: generationCount, completion: {})
            return GameOfLifeStarter(tick: tick)
        }
    }

    

}

public struct BuildError: Error {
    enum ErrorKind {
        case generationsNotConfiguredOrLowerThanZero
    }
    let kind: ErrorKind
         
}
