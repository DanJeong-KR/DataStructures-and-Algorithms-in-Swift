
import Foundation

public class TrieNode<Key: Hashable> { // 제네릭
    public var key: Key? // 노드의 데이터 
    public weak var parent: TrieNode? 
    // 부모노드 정보 가지고 있어야 삭제 연산을 구현 가능한데
    // 부모와 내가 서로 참조하고 있으면 강한참조문제가 발생할 가능성 있으므로 weak 써준거야.
    public var children: [Key: TrieNode] = [:] // 이진 트리와 다르게 자식 노드 오지게 많을 수 있지? dictionary
    public var isTerminating = false  // 한 단어면 끝에 점 표시했던거. 끝을 표시하는 용도.
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}


