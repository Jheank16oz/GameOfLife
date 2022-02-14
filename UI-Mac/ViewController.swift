//
//  ViewController.swift
//  UI-Mac
//
//  Created by jpineros on 13/02/22.
//

import Cocoa
import GameOfLife

class ViewController: NSViewController {

    
    @IBOutlet weak var labelPrint: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let builder = GameOfLifeStarter.Builder()
        builder.seed = .rpentomino20x20
        builder.generationCount = 100
        builder.update = {  [weak self] cells in
            guard let `self` = self else { return }
            self.labelPrint.stringValue = self.printSeed(seed: cells)
        }
        do {
            let game = try builder.build()
            game.start()
            
        } catch {
            print("Errror initializing")
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func printSeed(seed:[[State]]) -> String{
        var value = ""
        for (_,row) in seed.enumerated() {
            var rowString = ""
            for (_,col) in row.enumerated() {
                //let state = col == State.alive ? "🌸" : "🌿"
                //let state = col == State.alive ? "🤡" : "💤"
                //let state = col == State.alive ? "🐇" : "🐾"
                //let state = col == State.alive ? "🧝" : "🧟‍♂️"
                //let state = col == State.alive ? "🕷" : "🕸"
                let state = col == State.alive ? "❤️" : "🤍"
                rowString += "\(state)"
            }
            value += "\(rowString)\n"
        }
        return value
            
    }
    
    


}

