import UIKit


print(UIScrollView.DecelerationRate.fast.rawValue)
print(UIScrollView.DecelerationRate.normal.rawValue)

// BUD concepts
// Bottlenecks
// Unnecessary work
// Duplicated work

/// Unnecessary work

let n = 3
let range = 1...n

// before

/// - Complexity: big O(*n* *n* *n* *n*), where *n* is the length of the collection.

var arr = [1,2,3]
arr.sort()

for a in range {
    for b in range {
        for c in range {
            for d in range {
                if a*a*a + b*b*b == d*d*d + c*c*c {
                    print(a, b, c, d)
                }
            }
        }
    }
}

// after

/// - Complexity: big O(*n* *n* *n*), where *n* is the length of the collection.

for a in range {
    for b in range {
        for c in range {
            let d_in_cube: Double = Double(a*a*a) + Double(b*b*b) - Double(c*c*c)
            let d_double = round(pow(d_in_cube, 1.0/3.0))
            if !d_double.isNaN {
                
                let d = Int(d_double)
                
                if a*a*a + b*b*b == d*d*d + c*c*c {
                    print(a, b, c, d)
                }
            }
        }
    }
}

/// Duplicated work

var hashTable: [Int: (Int, Int)] = [:]

for c in range {
    for d in range {
        let result = c*c*c + d*d*d
        hashTable[result] = (c, d)
    }
}

for a in range {
    for b in range {
        let result = a*a*a + b*b*b
        if let list = hashTable[result] {
            print(a, b, list)
        }
    }
}
