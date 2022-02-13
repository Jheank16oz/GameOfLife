//
//  Seed.swift
//  GameOfLife
//
//  Created by jpineros on 13/02/22.
//

import Foundation


public class Seed {
    
    internal enum SeedType {
        case thereIsNotLife
        case strangeSeed
        case rpantomino
        case rpantomino2generation
    }
    

    internal static func generate5x5(seed:SeedType) -> [[State]]{
        
        var cells:[[State]] = [
            [.dead, .dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead, .dead],
            [.dead, .dead, .dead, .dead, .dead]]
        
        switch seed {
            case .thereIsNotLife:
                return cells
            
            case .strangeSeed:
                return [
                [.dead, .dead, ],
                [.dead, .alive, .alive, .dead,.dead, .alive, .alive, .dead],
                [.alive, .alive, .dead, .dead],
                [],
                [.dead, .dead, .dead]]
            case .rpantomino:
                cells[1][1] = .alive
                cells[2][1] = .alive
                cells[3][1] = .alive
                cells[2][0] = .alive
                cells[1][2] = .alive
                break
            case .rpantomino2generation:
                cells[1][0] = .alive
                cells[1][1] = .alive
                cells[3][0] = .alive
                cells[3][1] = .alive
                cells[2][0] = .alive
                cells[1][2] = .alive
                break
            
        }
       return cells
    }
    
}

