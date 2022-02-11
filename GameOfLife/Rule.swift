//
//  Rule.swift
//  GameOfLife
//
//  Created by jpineros on 11/02/22.
//

import Foundation

internal struct Rule{
  static let underpopulation = 2
  static let balanced = 3
  static let overpopulation = 4
  static let breed = 3
  
  static func isUnderPopulation(count: Int) -> Bool{
    return count < underpopulation
  }
  static func isBalanced(count: Int) -> Bool{
    return count <= balanced
    
  }
  static func isOverPopulation(count: Int) -> Bool{
    return count >= overpopulation
    
  }
  static func breed(count: Int) -> Bool{
    return count == breed
  }
}
