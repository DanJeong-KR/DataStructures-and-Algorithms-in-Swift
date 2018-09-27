

import Foundation

public class Node<Value> { // Node 클래스를 <Value> 라는 Generics 타입으로, public 으로 모든 모듈에서 접근 가능하도록 정의합니다.
    public var value: Value // 노드가 가지고 있는 값.
    public var next: Node? 
    // 노드가 가리키는 노드 (다음 노드)
    // 마지막 노드는 다음 노드가 nil 이기 때문에 옵셔널로 선언합니다. 
    
    public init (value: Value, next: Node? = nil) { 
        // 두 번째 매개변수 next 를 nil 로 초기화 이유 : 노드 인스턴스 생성할 때 두 번째 매개변수 next 를 굳이 명시하지 않아도 nil 로 초기화 하게 초기값 지정해 준 것.
        self.value = value
        self.next = next
    }
}
/*
 1. Node<Value> 의 <Value> 가 의미하는 것 : Generics . 추상화 시켜서 재사용 가능하게 하는 아이디어. <Value> 는 Node클래스의 value 프로퍼티의 타입을, 필요할 때마다 바꿔서 쓸 수 있도록 해 놓은 것. 함수의 매개변수와 역할이 비슷하다 . 매개변수에 어떤 값을 넣느냐에 따라 함수 내용이 달라지는 것과 같네.
 2. public 은 무엇을 의미? : Access Control of Swift, 해당 프로퍼티나 함수나 클래스나 구조체나 등등(이는 entity 라고 함.) 앞에 public , internal, fileprivate, private 등등의 키워드를 붙여서 내가 원하는 객체의 접근을 제한할 수 있다. public 은 제일 열린 접근이고, 제일 폐쇠적인 것이 private. 나누는 기준은 module 과 source file 이며, 예를 들어 private 는 해당 엔터티를 선언한 곳 안에서만 사용 가능.  -> Access Control 포스팅 후 다시 오자 정확한지 확신못하겠음.
 3. Node 는 Struct 아니라 Class로 작성한 이유? : 
 4. 노드의 값, public var 의 의미 (전역변수 인가?) : 모듈을 포함하지 않는 곳에서도 참조 가능하니 전역변수 역할이라고 생각해도 되는 듯. 이 부분도 Access Control 포스팅 후 다시.
 5. 노드가 가리키는 다음 노드, next의 자료형 Node 에 ?(옵셔널)이 붙은 이유는? : 연결 리스트는 연결안된 하나의 노드로만 구성되어 있을 수도 있고  , 여러 노드들이 연결된 상태일 수도 있는 2가지 경우가 존재한다. 하나의 노드만 있다면 다음 노드가 없는 상태이므로 next 변수가 nil 값이 된다. 다음 노드가 있다면 next 변수에 다음 노드가 들어간다. 이렇듯 next 에는 nil 이 될 수도 있고 안될 수도 있으므로 옵셔널 값이다.
 6. 두 번째 매개변수 next 를 nil 로 초기화 시켜준 이유는? : 다음 노드가 없는 단순 노드를 생성 하려면 next 에 굳이 nil 을 넣지 않고 value 값만 초기화 하면 되게 만든 것. 그렇게 하지 않았다면, 노드를 생성할 때마다 next 에 다음노드 혹은 nil 을 명시적으로 넣어주어야 컴파일 오류가 발생하지 않는다.
 */


extension Node: CustomStringConvertible { 
    //CustomStringConvertible 프로토콜을 채택하는 객체는 자기 타입에 대한  description을 제공해야 합니다.
    public var description: String { // 연산 프로퍼티 네요.
        guard let next = next else { // nil 이 아니라면, 즉 다음 노드가 있다면
            return "\(value)" // 다음 노드가 없다면 value 값만 출력시킴.
        }
        return "\(value) -> " + String(describing: next) + " " 
        // String(describing:) 메소드가 다음 노드의 description 을 호출합니다. 
        // 이는 결국 연쇄적으로 다음, 다음의 다음, 다음의 다음의 다음, 이렇게 연결리스트의 노드를 한 눈에 보여주는 역할을 합니다.
    }
}

/*
 7. CustomStringConvertible 프로토콜은 뭐하는 프로토콜? : 텍스트 표현을 사용자 정의, 즉 내가 정의해서 사용할 수 있게 하는 것. description을 저렇게 초기화 시켜놨으니 print(해당노드) 를 하면 내가 정의 해 눟은 문자열이 출력된다.
 
 */


