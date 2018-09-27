
import Foundation

public func example(of description: String, action: () -> Void) {
    print("---Example of \(description)---")
    // 첫 번째 매개변수에 테스트에 대한 설명 써주긔.^^
    action() 
    // 두 번째 매개변수 실행시키기
    // 이 함수를 쓸 때는 클로져를 활용할 예정입니다. 그래서 매개변수에 함수 타입이 들어간 것.
    print() // 한줄 띄우기 역할
}
