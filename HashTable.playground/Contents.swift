import Foundation

var dictionary: [String: String] = [:]
print(abs("name".hashValue) % 3)
print(abs("hobbie".hashValue) % 3)

dictionary["name"] = "Artem"
dictionary["name"] = "Football"

dictionary["name"]
dictionary["name"]

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty: Bool { return count == 0 }
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
}

let table = HashTable<String, String>(capacity: 5)
