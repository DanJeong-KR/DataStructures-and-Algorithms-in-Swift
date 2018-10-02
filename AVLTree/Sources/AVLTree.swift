import Foundation

// 이진 탐색 트리 랑 같습니다.
public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() {}
}
// MARK: - 트리 스스로 balance 조절하게 하는 메소드.
extension AVLTree {
    // (1 / 4) 왼쪽으로 회전. 오른 자식 노드가 unbalance 만들 면 왼쪽으로 회전시켜서 균형맞춰!
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild! // pivot 은 '중심점' 을 뜻함.
        // 매개변수로 들어오는 node를 루트노드로 하는 서브트리를 회전시키는 거야. 위 그림에서는 25 네
        // 25 의 오른 자식노드인 '27' 이 pivot 이 되겠네. pivot 은 회전될 서브 트리의 루트노드가 될 아이야.
        node.rightChild = pivot.leftChild
        // pivot 이 루트 노드가 될 거잖아. 그럼 내려가는 x 노드의 오른쪽 노드는 
        // x 노드보단 크고 y(pivot) 노드 보단 작은 b 노드가 되는거야. 파란색 펜으로 표시한 거야.
        pivot.leftChild = node
        // 왕권 교체 . x 노드는 y (pivot) 노드의 왼쪽 자식 노드가 되는 시점.
        node.height = max(node.leftHeight, node.rightHeight) + 1 // 노드 위치 바뀌었으니 heiht 수정
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1 // 마찬 가지.
        return pivot // 왕이된 놈 리턴. 그러니까 매개변수로 내려갈놈, 넣으면 왕이된놈 반환하는 거임.
    }
    // (2 / 4) 오른쪽 회전. 왼 자식노드가 unbalance 만들 면 오른쪽으로 회전 시킴.
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
        // leftRotate 와 원리가 같아요. 
    }
    // (3 / 4) 오른쪽이후 왼쪽으로 회전. 꼬여있을 때 하는거.
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { // 옵셔널 해제 해주고.
            return node // nil 이면 그냥 반환해버림
        }
        node.rightChild = rightRotate(rightChild) 
        // 먼저 오른 자식노드를 오른 회전 시킨 노드로 수정하고.
        return leftRotate(node) // 최종 왼쪽 회전 시킨 노드를 반환
    }
    // (4 / 4) 왼쪽이후 오른쪽으로 회전
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node}
        node.leftChild = leftRotate(leftChild) 
        return rightRotate(node)
        /* 이렇게도 테스트 해보자.
         node.leftChild = leftRotate(node.leftChild!)
         return rightRotate(node)
         */
    }
    // 밸런스 맞추는 게 필요한지 아닌지 판단하는 메소드
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        // 매개변수로 들어오는 해당 노드의 balancaFactor 로 unbalance 여부를 판단하는 메소드
        // balanceFactor 가 2 or 2 라서 unbalance 면 balance 트리로 수정하는 메소드를 내부에서으로 호출함
        switch node.balanceFactor { // 스위치 구문 활용하자.
        case 2:
            // 왼쪽 자식노드 쪽이 무거운 unbalance 트리.
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                // let leftChild = node.leftChild 로 먼저 옵셔널 해제 해주구~
                // 아 if 조건문에서 && 가 아닌 , 쓰는 건 앞에꺼 먼저 만족한 후 뒤의 구문 만족해야 한다는 뜻이야.
                // 왼쪽 자식노드가 무거운 (높이차가 2) 인 상태에서
                // , 뒤쪽 구문인 'leftChild.balanceFactor == -1' 은 중간에 있는 놈이 오른쪽으로 꺽인다는 뜻이야.
                // 구부러져 있는 상태에서는 사용하려고 rotation 메소드 중에 left-Right rotation 정의했었지?
                return leftRightRotate(node)
            }else {
                // 그런경우 아니라면 왼쪽이 무거우니까, 오른쪽으로 회전시키면 되.
                return rightRotate(node)
            }
        case -2:
            // 오른쪽 자식노드 무거워 
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                // 오른쪽 자식쪽이 무거운 상태에서 꺾여있다면 회전 2번 해야했지?
                return rightLeftRotate(node)
            }else {
                return leftRotate(node) // 오른쪽이 무거우니까 왼쪽으로 회전시켜서 balance 맞추자
            }
        default: // balance 상태에서는 매개변수로 들어온 노드를 그대로 반환시키는 거야. 수정하지 않고.
            return node
        }
    }
}
// 이진 트리와 같은 Insert 메소드
extension AVLTree {
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
            // 재귀함수에서 방향.
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        // 여기 추가하면 탐색하면서 높이가 2 이상 차이나는 게 있으면 바꾸구 리턴 반복
        let balancedNode = balanced(node) // 밸런스 필요한지 판단함. 필요하면 바꿈.
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        // 구조가 변했을 가능성이 있으므로 height 프로퍼티 재설정 해주구.
        return balancedNode
    }
}
// 이진 트리와 같은 Contains 메소드
extension AVLTree {
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}
// 최소값 구하는 거구
private extension AVLNode {
    
    var min: AVLNode {
        return leftChild?.min ?? self
    }
}
// 이진트리와 같은 Remove 메소드
extension AVLTree {
    
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        return balanceNode
    }
}


extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
