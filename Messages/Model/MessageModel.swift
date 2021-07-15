//
//  MessageModel.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import Foundation

struct MessageModel {
    var senderId: Int
    var sender: String
    var demoMessage: String
}

enum SearchType: Int {
    case image, text, user
}

struct SearchDataModel {
    var link: String?
    var text: String?
    var sender: String?
    var senderId: Int?
}

struct SearchedModel {
    var type: SearchType
    var data: [SearchDataModel]? // other than type text
    var singleData: SearchDataModel? // type text
}
