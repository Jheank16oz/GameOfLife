//
//  Seed.swift
//  GameOfLife
//
//  Created by jpineros on 13/02/22.
//

import Foundation


    
public enum KindSeed {
    case rpentomino5x5
    case rpentomino20x20
    case thereIsNotLife5x5
    case strangeSeed
    case rpentomino2generation5x5
}
    
public  func generateSeed(kind:KindSeed)-> [[State]]{
    var cells = [[State]]()
    
    cells = [
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead],
        [.dead, .dead, .dead, .dead, .dead]]
        
    
    switch kind {
        case .rpentomino20x20:
            cells = generate20x20()
            cells[9][9] = .alive
            cells[9][10] = .alive
            cells[10][8] = .alive
            cells[10][9] = .alive
            cells[11][9] = .alive
            break
        case .thereIsNotLife5x5:
            return cells
        
        case .strangeSeed:
            return [
            [.dead, .dead, ],
            [.dead, .alive, .alive, .dead,.dead, .alive, .alive, .dead],
            [.alive, .alive, .dead, .dead],
            [],
            [.dead, .dead, .dead]]
        case .rpentomino5x5:
            cells[1][1] = .alive
            cells[2][1] = .alive
            cells[3][1] = .alive
            cells[2][0] = .alive
            cells[1][2] = .alive
            break
        case .rpentomino2generation5x5:
            cells[1][0] = .alive
            cells[1][1] = .alive
            cells[3][0] = .alive
            cells[3][1] = .alive
            cells[2][0] = .alive
            cells[1][2] = .alive
            break
        
    }
    return cells;
}

private func generate20x20() -> [[State]]{
    var cells = [[State]]()
    for _ in 1 ... 20 {
        var row = [State]()
        for _ in 1 ... 20 {
            row.append( .dead)
        }
        cells.append(row)
    }
    return cells
}
    
