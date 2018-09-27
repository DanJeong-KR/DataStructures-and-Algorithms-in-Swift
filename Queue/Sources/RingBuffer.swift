
import Foundation

public struct RingBuffer<T> {
    
    private var array: [T?] // 고정된 크기의 배열입니다.
    private var readIndex = 0 // RingBuffer 의 Read 입니다.
    private var writeIndex = 0 // RingBuffer 의 Write 입니다.
    
    public init(count: Int) {
        array = Array<T?>(repeating: nil, count: count) 
        // 고정된 크기의 배열을 사용하기 때문에 배열의 크기인 count 를 초기화 함수에 넣어야 합니다.
    }
    
    public var first: T? { 
        return array[readIndex]
        // RingBuffer 의 Read 인 readIndex 를 읽어오면 큐의 첫번째 값입니다.
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
        // 읽을 수 있는 개수를 표현한 것.
    }
    
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
        // writeIndex 와 readIndex 가 같은 위치에 있으면 빈 큐입니다.
        // wirte 이 한바퀴 돌아서 올 수 있지 않냐는 의문이 들지만
        // 뒤에 나올 isFull 프로퍼티로 그 오류를 막습니다. 
    }
    
    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
        // 큐에 값을 추가하는 wirte 을 할 수 있는 것을 표현
        // 고정된 배열이기 때문에 배열의 크기에서 읽을 수 있는 개수 빼면 나머지가 입력할 수 있는 개수죠?
    }
    
    public var isFull: Bool {
        return availableSpaceForWriting == 0
        // 배열이 가득 차면 writeIndex 가 한바퀴 돌아서 Read 랑 같은 위치에 놓이는 경우를 그림으로 보셨쥬?
        // 그 경우를 예로 들면 array.count = 4 고 availableSpaceForReading 도 4라
        // availableSpaceForWriting 는 0 가 되겠쥬?
        // 이런 식으로 큐가 가득 찬 경우를 표현합니다.
        // 가득 찼다면 더 이상 write 을 수행할 수 없게 제한해야 하기 때문에 꼭 필요한 부분입니다.
    }
    
    public mutating func write(_ element: T) -> Bool { // 큐에 값 입력하는 역할의 메소드
        if !isFull { // 가득 찼는지 먼저 확인하구요.
            array[writeIndex % array.count] = element 
            // % 연산(나누어 떨어지는)을 사용해서 끝에서 다시 되돌아 오는 것을 표현합니다.
            writeIndex += 1 // write 수행할 때마다 writeIndex 한 칸씩 앞으로 감을 표현합니다.
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {// 큐에 먼저 들어온 값을 제거하는 역할의 메소드.
        if !isEmpty {
            let element = array[readIndex % array.count] // 마찬가지로 %
            readIndex += 1 // 마찬가지로 한 칸씩 앞으로
            return element
        } else {
            return nil
        }
    }
}

extension RingBuffer: CustomStringConvertible {
    public var description: String {
        let values = (0..<availableSpaceForReading).map {
            // 0..<availableSpaceForReading 은 읽을 수 있는 범위를 Range 구조체로 표현하는 것입니다.
            // 0..< 이 기호가 Range 구조체.
            // 우리가 출력할 것이 큐 안에 있는 값이죠?
            // 큐 안에 있는 값이라는 것은 아직 제거되지 않은 값 부터 새로 추가된 값 까지 를 뜻하죠?
            // 그것을 표현한 것이 availableSpaceForReading(writeIndex - readIndex) 입니다.
            // 그 범위를 표현한 Range 구조체에서 map 메소드를 사용해서 문자열로 변환합니다.
            String(describing: array[($0 + readIndex) % array.count]!)
            // String(describing:) 은 String 구조체의 초기화 함수죠? 
            // 매개변수에 들어온 타입의 description을 출력하는 것이죠.
            // $0 은 클로저에서 첫 번째 매개변수를 뜻합니다. 
            // collection 타입에서 map 메소드를 쓰면 $0 는 해당 범위의 각각의 값을 표현합니다.
            // 배열의 크기가 7 인 RingBuffer 로 예를 들면 아래 그림과 같습니다.
        }
        return String(describing: values)
    }
}

