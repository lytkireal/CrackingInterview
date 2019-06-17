import UIKit

// head pointer
// .
// .
// .
// objects pointers
// .
// .
// .
// tail pointer

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
        return nodesCount
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
        
        nodesCount += 1
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
}

let list = LinkedList<Float>()
list.append(value: 3.44)
list.isEmpty
list.first?.value
list.last?.value

list.append(value: 4.11)
list.first?.value
list.last?.value

list.first?.previous
list.first?.next?.value
list.last?.previous?.value
list.last?.next

list.append(value: 6.33)

list.count

list[0]
list[1]
list[2]

