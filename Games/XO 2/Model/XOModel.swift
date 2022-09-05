//
//  XOModel.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import SwiftUI

class TicTacToeModel : ObservableObject {
    @Published var cells = [Cell]()
    
    init() {
        for _ in 0...8 {
            cells.append(Cell(status: .empty))
        }
    }
    
    func resetGame() {
        for i in 0...8 {
            cells[i].cellStatus = .empty
        }
    }
    
    var gameOver : (CellStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return (thereIsAWinner, true)
            } else {
                for i in 0...8 {
                    if cells[i].cellStatus == .empty {
                        return(.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }
    
    private var thereIsAWinner: CellStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2]) {
                return check
            } else  if let check = self.checkIndexes([3, 4, 5]) {
                return check
            }  else  if let check = self.checkIndexes([6, 7, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 3, 6]) {
                return check
            }  else  if let check = self.checkIndexes([1, 4, 7]) {
                return check
            }  else  if let check = self.checkIndexes([2, 5, 8]) {
                return check
            }  else  if let check = self.checkIndexes([0, 4, 8]) {
                return check
            }  else  if let check = self.checkIndexes([2, 4, 6]) {
                return check
            }
            return .empty
        }
    }
    
    private func checkIndexes(_ indexes : [Int]) -> CellStatus? {
        var homeCounter : Int = 0
        var visitorCounter : Int = 0
        for index in indexes {
            let cell = cells[index]
            if cell.cellStatus == .home {
                homeCounter += 1
            } else if cell.cellStatus == .visitor {
                visitorCounter += 1
            }
        }
        if homeCounter == 3 {
            return .home
        } else if visitorCounter == 3 {
            return .visitor
        }
        return nil
    }
    
    private func moveAI() {
        var index = Int.random(in: 0...8)
        while makeMove(index: index, player: .visitor) == false && gameOver.1 == false {
            index = Int.random(in: 0...8)
        }
    }
    
    func makeMove(index: Int, player: CellStatus) -> Bool {
        if cells[index].cellStatus == .empty {
            cells[index].cellStatus = player
            if player == .home {
                moveAI()
            }
            return true
        }
        return false
    }
}


