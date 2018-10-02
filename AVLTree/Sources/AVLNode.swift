
import Foundation

public class AVLNode<Element> {
    
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    
    public var height = 0 
    // 여기서 높이란 해당 노드부터 leaf 노드 까지의 길이를 뜻하는 거야.
    // height 프로퍼티가 balance 상태인지 판단하는 기준이야. 
    // height 를 이용해서 leftHeight, rightHeight를 구하고 이를 이용해서 balanceFactor 를 구한다.
    public var balanceFactor: Int {
        return leftHeight - rightHeight // 왼쪽과 오른쪽 자식노드의 height 프로퍼티 차이.
    }
    public var leftHeight: Int { 
        // nil 이면 -1 는 자식노드 없으면 높이 -1 로 친다는 거야.
        // leaf 노드가 0 이기 때문에 높이차가 1 이상이라는 걸 표현하기 위해서는 nil 일 때 -1 로 설정해주면 되.
        return leftChild?.height ?? -1
    }
    public var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    
    public init(value: Element) {
        self.value = value
    }
    // 이진 트리 탐색 알고리즘 3 가지.
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}
// 이진 트리 출력 하는 것도 가져옴.
extension AVLNode: CustomStringConvertible {
    
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}


