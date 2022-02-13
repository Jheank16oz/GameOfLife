//
//  Tick.swift
//  GameOfLife
//
//  Created by jpineros on 11/02/22.
//

import Foundation

class Tick{
    
    var generation:Int
    let completion:()->Void
    let game:GameOfLife
    var timer:Timer?
    init(game: GameOfLife, generation:Int,completion:@escaping ()->Void){
        self.generation = generation
        self.completion = completion
        self.game = game
    }
    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    
    @objc func tick() {
        
        game.nextGeneration()
        generation -= 1
        if generation <= 0 {
            completion()
            timer?.invalidate()
        }
        
    }
    

}
