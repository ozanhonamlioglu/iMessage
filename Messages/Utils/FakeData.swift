//
//  FakeData.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import Foundation

let listMessages: [MessageModel] = [
    MessageModel(senderId: 1, sender: "Google", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 2, sender: "Facebook", demoMessage: "Hi..."),
    MessageModel(senderId: 3, sender: "Amazon", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 4, sender: "Netflix", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 5, sender: "Yahoo", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 6, sender: "Tesla", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 7, sender: "Inveon", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 8, sender: "Yemek Sepeti", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 9, sender: "Hepsiburada", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 10, sender: "Starbucks", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 11, sender: "My love 🌹", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 12, sender: "Jack", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 13, sender: "Katie", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
]

let pinnedMessages: [MessageModel] = [
    MessageModel(senderId: 1, sender: "Google", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
    MessageModel(senderId: 2, sender: "Facebook", demoMessage: "Hi..."),
    MessageModel(senderId: 3, sender: "Amazon", demoMessage: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
]

let customSearchData: [SearchedModel] = [
    SearchedModel(type: .user, data: [
        SearchDataModel(sender: "Google", senderId: 1),
        SearchDataModel(sender: "My Love 🌹", senderId: 11),
        SearchDataModel(sender: "Jack", senderId: 12)
    ]),
    SearchedModel(type: .image, data: [
        SearchDataModel(link: "https://picsum.photos/300/300"),
        SearchDataModel(link: "https://picsum.photos/300/300"),
        SearchDataModel(link: "https://picsum.photos/300/300"),
    ]),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "Netflix", senderId: 4)),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "My Love 🌹", senderId: 11)),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "Jack", senderId: 12)),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "Katie", senderId: 13)),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "Hepsiburada", senderId: 9)),
    SearchedModel(type: .text, singleData: SearchDataModel(link: "", text: "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", sender: "Yahoo", senderId: 5)),
]
