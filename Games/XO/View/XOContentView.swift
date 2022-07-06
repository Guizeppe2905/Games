//
//  XOContentView.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import SwiftUI
import MetalKit

struct GameView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        ZStack {
            VStack {
             
                    
            Text("Крестики - нолики")
                .bold()
                .foregroundColor(Color.white)
                .padding(.bottom)
                .font(.title2)
        
            ForEach(0 ..< ticTacToeModel.cells.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        CellView(dataSource: ticTacToeModel.cells[index], action: {self.buttonAction(index)})
                    })
                }
            })
        }
            .padding(.leading, 60)
            .padding(.top, -10)
        .alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Игра окончена"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "Вы победили!": "Вы проиграли!" : "Ничья" ) , dismissButton: Alert.Button.destructive(Text("Ok"), action: {
                    self.ticTacToeModel.resetGame()
                  }))
            
        })
        }  .padding()
            .background(Color(Constants.Colors.basicGray!))
    }
      
}

