//
//  Library.swift
//  ReadMe
//
//  Created by Guilherme de Carvalho Correa on 24/04/23.
//

import Combine
import SwiftUI

enum Section: CaseIterable {
  case readMe
  case finished
}

class Library: ObservableObject {
  var sortedBooks: [Section: [Book]] {
    get {
      let groupedBooks = Dictionary(grouping: booksCache, by: \.readMe)
      return Dictionary(uniqueKeysWithValues: groupedBooks.map {
        (($0.key ? .readMe : .finished), $0.value)
      })
    }
    set {
    booksCache =
      newValue
      .sorted { $1.key == .finished }
      .flatMap { $0.value }
    }
  }
  
  func sortBooks() {
    booksCache = sortedBooks
      .sorted { $1.key == .finished }
      .flatMap { $0.value }
    objectWillChange.send()
  }
  
  /// Adds a new book at the start of the library's manually-sorted books.
  func addNewBook(_ book: Book, image: Image?) {
    booksCache.insert(book, at: 0)
    images[book] = image
  }
  
  func deleteBooks(atOffsets offsets: IndexSet, section: Section) {
    let booksBeforeDeletion = booksCache
    
    sortedBooks[section]?.remove(atOffsets: offsets)
    
    for change in booksCache.difference(from: booksBeforeDeletion) {
      if case .remove(_, let deletedBook, _) = change {
        images[deletedBook] = nil
      }
    }
  }
  
  func moveBooks(oldOffsets: IndexSet, newOffset: Int, section: Section) {
    sortedBooks[section]?.move(fromOffsets: oldOffsets, toOffset: newOffset)
  }
  
  /// An in-memory cache of the manually-sorted books.
  @Published private var booksCache: [Book] = [
//    .init(title: "Ein Neues Land", author: "Shaun Tan", microReview: "One of the best!"),
//    .init(title: "Bosch", author: "Laurinda Dixon"),
//    .init(title: "Dare to Lead", author: "Brené Brown"),
//    .init(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet"),
//    .init(title: "Drinking with the Saints", author: "Michael P. Foley"),
//    .init(title: "A Guide to Tea", author: "Adagio Teas"),
//    .init(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson"),
//    .init(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
//    .init(title: "How to Draw Cats", author: "Janet Rancan"),
//    .init(title: "Drawing People", author: "Barbara Bradley"),
//    .init(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
  ]
  
  @Published var images: [Book: Image] = [:]
}
