//
//  Note.swift
//  WatchTodo WatchKit Extension
//
//  Created by 鳥山英峻 on 2022/04/16.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
