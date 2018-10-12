
import Foundation

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    // Trie 의 제네릭 타입인 CollectionType 은 Collection 프로토콜을 채택한 것이어야.
    // 그러한 CollectionType 중에 Element 가 Hashable 프로토콜을 채택한 것이어야 함.
    public typealias Node = TrieNode<CollectionType.Element> // 너무 기니까
    
    private let root = Node(key: nil, parent: nil) // 루트 노드
    
    public init(){ }
    
    public func insert(_ collection: CollectionType) {
        var current = root // 루트를 시작으로 추적하겠다는 아이디어
        
        for element in collection { // 추가하는 과정.
            // for loop 에 collection 쓸 수 있는 이유는 Collection protocol 채택했기 때문
            if current.children[element] == nil {  // 없는 거면 새로운 인스턴스 만든다.
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]! // 반복문 다음입력으로~
        }
        current.isTerminating = true // 단어 완성 시켰으면 마지막 알파벳에 점찍어주기~
    }
    
    public func contains(_ collection: CollectionType) -> Bool{
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else { // 노드가 nil 이면 없는거니까.
                return false // 끝까지 와서 일치하는게 없으면 false 반환
            }
            current = child // 입력 다음입력으로 변화
        }
        return current.isTerminating // 있다면 끝 부분 isTerminating 반환.
    }
    
    public func remove(_ collection: CollectionType) {
        
        var current = root
        for element in collection { 
            guard let child = current.children[element] else { return }
            current = child
        }
        guard current.isTerminating else { return print("완성 단어가 아님.") } 
        // dot 찍혀있는지 확인. 정확한 단어 찾았는지 확인
        // 동시에 루트노드가 아니란 것도 알 수 있음.
        current.isTerminating = false // dot 먼저 해제 시켜주구 먼저 지우구.
        while current.children.isEmpty && !current.isTerminating{ 
            // 1. 자식 노드가 비어있지 않으면 중복되지만 더 긴 단어가 있다는 것이므로 삭제하면 안돼!
            // 2. dot 찍혀있으면 다른 단어가 있는 것이니 더 이상 지우면 안돼
            current.parent!.children[current.key!] = nil 
            current = current.parent!
        }
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    // RangeReplaceableCollection 프로토콜은 Collection 프로토콜을 상속한 프로토콜
    // Array 의 append 메소드는 Array가 RangeReplaceableCollection 프로토콜을을 상속해서 쓸 수 있는 것!
    public func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        for element in prefix {
            guard let child = current.children[element] else { return [] } // if 문 실행해보기
            current = child
        }
        return collections(startingWith: prefix, after: current)
        // 접두어 끝이 현재의 현재 노드니까 현재노드에 딸려있는 단어들 배열로 가져올 메소드 따로 만들자.
    }
    
    private func collections(startingWith prefix: CollectionType,
                             after node: Node)                     
                             -> [CollectionType] 
    {
        var result = [CollectionType]() // 단어들 여기에 담을거야
        if node.isTerminating { // prefix 자체가 한 단어이면 반환배열에 포함시켜야지?
            result.append(prefix) 
        }
        for child in node.children.values { 
            // values 는 dictionary 구조체의 프로퍼티임^^
            // 자식 노드의 수만큼만 반복 => 자식노드 없으면 반복 안함.
            var prefix = prefix
            prefix.append(child.key!) 
            // 자식노드 있는지 확인 안하고 강제 언래핑 가능. 반복 횟수가 이미 정해저 있으니까.
            // prefix 는 RangeReplaceableCollection 프로토콜을 채택한 타입이기 때문에 append 메소드 사용 가능.
            result.append(contentsOf: collections(startingWith: prefix, after: child)) 
            // 재귀호출 시작, 1. 종료조건 : 반복문의 node.children.values 이 0 이면 종료 -> 만족
            // 2. 작은 방향으로 이루어 지는지 : prefix 가 커져서 트리의 자식노드인 하위로 이동하므로 문제의 범위는 작아짐. -> 만족
        }
        return result
    }
}


