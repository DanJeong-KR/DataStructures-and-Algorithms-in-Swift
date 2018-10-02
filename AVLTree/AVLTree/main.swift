
import Foundation

var tree = AVLTree<Int>()
tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(4)
tree.insert(5)
print(tree) // 제거하기 전 트리 출력
var treeRemove = tree
treeRemove.remove(4) // 4 제거.
print(treeRemove) // 제거한 후 트리 출력
