
import Foundation

public struct QueueDoubleStack<T>: Queue {
    private var leftStack = Array<T>() // enQueue 를 담당할 왼쪽 스택
    private var rightStack = Array<T>() // deQueue 를 담당할 오른쪽 스택
    
    public init() {}
    
    //Queue 프로토콜 사항들.
    public mutating func enQueue(_ element: T) -> Bool {
        rightStack.append(element) // 오른쪽 스택에 append 메소드 사용해서 배열에 값 추가하면 끝.
        return true
    }
    
    public mutating func deQueue() -> T? {
        if leftStack.isEmpty { 
            // dequeue 목록인 왼쪽 배열이 비어있지 않다면, 그냥 반환만 하면 되.
            // 비어있는지 확인하는 연산은 은근히 중요한 역할을 합나다.
            // 비어있을 때에만 스택의 값들을 옮기는 과정을 수행하므로 값들이 꼬일 일이 없죠.
            leftStack = rightStack.reversed() 
            // 거꾸로 정렬해서 제일 먼저 들어온 값이 맨 끝으로 가므로 거꾸로 정렬.
            rightStack.removeAll() 
            // 왼쪽 스택이 비어있어서 값을 제거하기 위해 오른쪽 스택 값들이 왼쪽으로 옮겨진다면
            // 옮겨진 오른쪽 스택 값들은 모두 제거됩니다. 그리고 새로 큐에 들어오는 값을 받는 겁니다.
        }
        return leftStack.popLast()
    }
    
    public var isEmpty: Bool { // 두 스택 모두 비어있어야 빈 큐 입니다.
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
        // 왼쪽 스택에 아이템이 있을 때 큐의 성격인 맨 앞을 표현하려면 
        // 거꾸로 정렬됬기 때문에 스택의 마지막 값이 되므로 leftStack.last 을 해줘야쥬?
        // 왼쪽 스택이 기준이 되는 이유는 
        // 두 스택에서 peek 이 원하는 가장 먼저 들어온 값은 deQueue 스택인 왼쪽스택이 기준이기 때문입니다.
        // 오른쪽 스택을 먼저 확인하면 왼쪽스택에 더 먼저 들어온 값이 있더라도 오른쪽 스택의 늦은 값을 선택하게 됨을 유의.
    }
}

extension QueueDoubleStack: CustomStringConvertible {
    public var description: String {
        let printList = leftStack.reversed() + rightStack
        // 두 스택 모두가 큐의 전체 값이므로 큐를 표혀하려면 연결해서 표현해야 하쥬?
        return String(describing: printList)
    }
}
