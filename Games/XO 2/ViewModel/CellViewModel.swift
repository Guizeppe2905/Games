//
//  CellViewModel.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import SwiftUI

struct CellView: View {
    @ObservedObject var dataSource: Cell
    var action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.cellStatus == .home ?
                    "X" : self.dataSource.cellStatus == .visitor ? "0" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.teal)
                .frame(width: 70, height: 70, alignment: .center)
                .background(Color.white.cornerRadius(10))
                .padding(4)
        })
    }
}
