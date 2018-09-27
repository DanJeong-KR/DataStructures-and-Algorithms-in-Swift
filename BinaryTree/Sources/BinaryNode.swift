
import Foundation

public class BinaryNode<Element> {
    
    //MARK: - 전처리 부분
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    public init(value: Element) {
        self.value = value
    }
    
    //MARK: - In-order 검색
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit) 
        // 왼쪽 노드 먼저 재귀 호출 시작.
        // 매개변수에 상위 visit 쓴 것은 같은 클로저를 쓰겠다. 즉 print($0) 하겠다는 말.
        // 그림에서 보세용.
        visit(value) 
        // 클로저로 들어온 visit 에 value 를 매개변수로 넣어서 실행.
        // 그러니까 print($0) 의 $0 는 현재 인스턴스의 value 가 되겠쥬? 이건 7 이겠네.
        // 가운대에 노드 출력하는 연산 있으므로 in-order
        rightChild?.traverseInOrder(visit: visit)
        // 마지막 순서로 오른쪽
    }
    //MARK: - Pre-order 검색
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value) // 노드 출력하고 재귀하쥬? 그래서 pre-order
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    //MARK: - Post-order
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value) // 노드 출력을 가장 늦게 하쥬? 그래서 post-order
        // 루트 노드는 항상 마지막에 출력되겠쥬?
    }
}


// 출력하는 부분은 직접작성한 게 아니라 아래 링크에서 가져왔습니다.
extension BinaryNode: CustomStringConvertible {
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
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
