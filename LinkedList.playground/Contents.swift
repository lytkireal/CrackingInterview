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

enum ListNode<T> {
    indirect case node(T, next: ListNode<T>)
    case end
}

public struct LinkedListIndex<T>: Comparable {

    fileprivate let node: LinkedList<T>.LinkedListNode<T>?
    fileprivate let tag: Int
    
    public static func==<T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    public static func< <T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return lhs.tag < rhs.tag
    }
}



public class LinkedList<T> {
    
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var nodesCount: Int = 0
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node?
    
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
        
        last = newNode
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
    
    @discardableResult
    public func remove(node: Node) -> T {
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
        // begin
        var node = head
        last = head
        
        // move to the next node
        while let currentNode = node {
            
            // get pointer of the next node for moving through linked list
            node = currentNode.next

            // swap addresses of nodes next - previous for current node
            swap(&currentNode.next, &currentNode.previous)
            
            // move head pointer to the next node
            head = currentNode
        }
    }
    
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        
        while node != nil {
            result.append(value: transform(node!.value))
            node = node!.next
        }
        
        return result
    }
    
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        
        var node = head
        
        while node != nil {
            if predicate(node!.value) {
                result.append(value: node!.value)
            }
            node = node?.next
        }
        
        return result
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

// MARK: - Collection

extension LinkedList: Collection {
    
    public typealias Index = LinkedListIndex<T>
    
    /// The position of the first element in nonempty collection.
    ///
    /// If the collection is empty, `startIndex` is equal to `endIndex`.
    /// - Complexity: O(1)
    public var startIndex: Index {
        get {
            return LinkedListIndex<T>(node: head, tag: 0)
        }
    }
    
    /// The collection's "past the end" position --- that is, the position one
    /// greater than the last valid subscript argument.
    /// - Complexity: O(n), where n is the number of elements in the list. This can be improved by keeping a reference
    /// to the last node in the collection.
    public var endIndex: Index {
        get {
            if let l = last {
                return LinkedListIndex<T>(node: l, tag: count)
            } else {
                return LinkedListIndex<T>(node: nil, tag: startIndex.tag)
            }
        }
    }
    
    public subscript(position: Index) -> T {
        get {
            return position.node!.value
        }
    }
    
    public func index(after idx: Index) -> Index {
        return LinkedListIndex<T>(node: idx.node?.next, tag: idx.tag + 1)
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

list.count

list.insert(Float(20.3), atIndex: 1)
list.insert(Float(20.3), atIndex: 0)
list.insert(Float(20.3), atIndex: 4)

print(list[0])
print(list[1])
print(list[2])
print(list[3])
print(list[4])
print(list[5])

list.count

list.removeAll()

list.count

list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)

list.reverse()

let newList = LinkedList<String>()

newList.append(value: "London")
newList.append(value: "New Yourk")
newList.append(value: "Tokio")

let length = newList.map { s in
    return s.count }

print(length)

let filtered = newList.filter { s in
    return s.count > 5
}


print(filtered)

print("before reverse")
print(newList)
//newList.reverse()
newList.insert("Helsinki", atIndex: 0)

newList.reverse()
print("after reverse")
print(newList)

let endIndex = newList.endIndex
let startIndex = newList.startIndex
print(newList[endIndex])
print(newList[startIndex])
