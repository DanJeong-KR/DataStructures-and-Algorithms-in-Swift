
import Foundation
/*
var bst = BinarySearchTree<Int>()

for i in 0..<4 {
    bst.insert(i)
}
print(bst)
*/


var exampleTree: BinarySearchTree<Int> {
    var bst = BinarySearchTree<Int>()
    bst.insert(50)
    bst.insert(25)
    bst.insert(75)
    bst.insert(12)
    bst.insert(10)
    bst.insert(17)
    bst.insert(37)
    bst.insert(32)
    bst.insert(45)
    bst.insert(27)
    bst.insert(33)
    bst.insert(63)
    bst.insert(87)
    return bst
}

var a = exampleTree
print(a)
print("\n")

a.remove(25)
print(a)
