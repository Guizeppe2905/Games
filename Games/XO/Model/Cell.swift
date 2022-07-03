//
//  Cell.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import Foundation

enum CellStatus {
    case empty
    case home
    case visitor
}
class Cell: ObservableObject {
    @Published var cellStatus: CellStatus
    init(status: CellStatus) {
        self.cellStatus = status
    }
}

