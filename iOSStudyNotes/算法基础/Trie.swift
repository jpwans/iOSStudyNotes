//
//  Trie.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/21.
//

import Foundation
import SwiftyJSON

class Node {
    var wordEnd = false
    var next : [Character : Node] = [:]
    
}

class Trie {
    
    let root = Node()

    
    init() {
        
    }
    
    func isWord(_ str:String) -> Bool {
 
//        [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"]
        return false
    }
    
    func insert(_ word:String){
        var currentNode = root
        for c in word {
            if let nextNode = currentNode.next[c] {
                currentNode = nextNode
            }
            else {
                let nextNode = Node()
                currentNode.next[c] = nextNode
                currentNode = nextNode
            }
        }
        currentNode.wordEnd = true
    }
    
    func search(_ word: String) -> Bool {
        var currentNode = root
        for c in word {
            if let node = currentNode.next[c] {
                currentNode = node
            }
            else{
                return false
            }
        }
        return currentNode.wordEnd
    }
    
    func startsWith(_ prefix:String) -> Bool {
        var currentNode = root
        for c in prefix {
            if let node = currentNode.next[c] {
                currentNode = node
            }
            else {
                return false
            }
        }
        return true
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
    
        // 1
        var currentNode = root
    
        // 2
        let characters = Array(word.lowercased())
        var currentIndex = 0
    
        // 3
        while currentIndex < characters.count,
          let child = currentNode.next[characters[currentIndex]] {
    
          currentNode = child
          currentIndex += 1
        }
    
        // 4
        if currentIndex == characters.count && currentNode.wordEnd {
          return true
        } else {
          return false
        }
    }
}



func _convertSetToTrie(_ dict:Set<String>) -> Trie {
    let trie = Trie();
    
    return trie;
}
