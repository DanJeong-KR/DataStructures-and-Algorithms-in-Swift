
import Foundation

public func gcd_recur(a:Int, b:Int) -> Int { // greatest common divisor
    if a == b { return a }
    else if a > b { // 
        if a % b == 0 { return b } // 요구사항 1. 종료조건
        else { return gcd_recur(a: b, b: a % b) } 
        // 요구사항 2. 입력값 a 가 a보다 작은 b로, b 는 a % b 로 작아짐.
    }else{
        if b % a == 0{ return a } // 종료조건
        else { return gcd_recur(a: a, b: b % a) }
    }
}

public func gcd_for(a:inout Int, b:inout Int) -> Int {
    // 함수 내부에서 변수 a, b 가 변경되므로 inout 을 붙인 것입니다. 
    if a == b { return a }
    else if a > b {
        while b != 0 {
            let r = a % b
            a = b
            b = r
        }
        return a
    }else { // a < b 인 경우에 a, b 위치만 바꿔주면 됩니다^^
        gcdProcess(a: &b, b: &a)
        return b
    }
}
 // 하는 김에 최대 공배수 보너스 . 두 정수의 곲 / 최대 공약수 하면 최소공배수 나옴.
public func lcm(a: Int, b: Int) -> Int {
    return a * b / gcd_recur(a: a, b: b)
}

private func gcdProcess (a:inout Int, b:inout Int){
    while b != 0 {
        let r = a % b
        a = b
        b = r
    }
}
