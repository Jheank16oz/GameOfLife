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
        case rpentomino
        case rpentomino2generation
    }
    
    public enum KindSeed {
        case rpentomino
    }
    
    func generate20x20(kind:KindSeed)-> [[State]]{
        var cells = [[State]]()
        
        for _ in 1 ... 20 {
            var row = [State]()
            for _ in 1 ... 20 {
                row.append( .dead)
            }
            cells.append(row)
        }
        
        switch kind {
            case .rpentomino:
                cells[9][9] = .alive
                cells[9][10] = .alive
                cells[10][8] = .alive
                cells[10][9] = .alive
                cells[11][9] = .alive
                break
        }
        
        
        return cells;
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
            case .rpentomino:
                cells[1][1] = .alive
                cells[2][1] = .alive
                cells[3][1] = .alive
                cells[2][0] = .alive
                cells[1][2] = .alive
                break
            case .rpentomino2generation:
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

