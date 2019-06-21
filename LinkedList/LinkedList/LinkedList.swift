//
//  LinkedList.swift
//  LinkedList
//
//  Created by Artem Lytkin on 21/06/2019.
//  Copyright © 2019 Artem Lytkin. All rights reserved.
//

import Foundation

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var nodesCount: Int = 0
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        
        return node
    }
    
    public var count: Int {
        guard var node = head else { return 0 }
        var count = 1
        while let next = node.next {
            count += 1
            node = next
        }
        return count
    }
}

extension LinkedList {
    public func append(value: T) {
        let newNode = Node(value: value)
        
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func nodeAt(index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { //(*1)
                    break
                }
            }
            return node!
        }
    }
    
    public subscript(index: Int) -> T {
        let node = nodeAt(index: index)
        return node.value
    }
    
    /// - Parameters:
    ///     - value: The data value to be inserted
    ///     - index: Integer value of the index to be inserted
    
    public func insert(_ value: T, atIndex index: Int) {
        let newNode = Node(value: value)
        
        if index == 0 {
            head?.previous = newNode
            newNode.next = head
            head = newNode
        } else {
            let oldNode = nodeAt(index: index)
            let previous = oldNode.previous
            previous?.next = newNode
            newNode.next = oldNode
        }
    }
    
    @discardableResult public func remove(node: Node) -> T {
        let previous = node.previous
        let next = node.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    @discardableResult
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    public func removeAll() {
        head = nil
    }
    
    public func remove(at index: Int) -> T {
        let node = nodeAt(index: index)
        
        assert(!isEmpty)
        
        return remove(node: node)
    }
    
    public func reverse() {
        var node = head
        if let currentNode = node {
            node = currentNode.next
            print("*****************************")
            print("node value: \(node?.value)")
            let nextNextNode = currentNode.next?.next
//            print("currentNode: \(currentNode.value)")
//            print("prevNode: \(currentNode.previous?.value)")
//            print("prevPrevNode: \(currentNode.previous?.previous?.value)")
//            print("nextNode: \(currentNode.next?.value)")
//            print("nextNextNode: \(currentNode.next?.next?.value)")
            print("-------------------------------")
            swap(&currentNode.next, &currentNode.previous)
//            print("prevNode after swap: \(currentNode.previous?.value)")
//            print("prevPrevNode after swap: \(currentNode.previous?.previous?.value)")
//            print("nextNode after swap: \(currentNode.next?.value)")
//            print("nextNextNode after swap: \(currentNode.next?.next?.value)")
            
            print(nextNextNode?.previous?.previous?.value)
            print(nextNextNode?.previous?.value)
            print(nextNextNode?.value)
            print(nextNextNode?.next?.value)
            print(nextNextNode?.next?.next?.value)
            
            print(currentNode.next?.value)
            print(description)
            print("node value: \(node?.value)")
            
            head = currentNode
        }
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}
