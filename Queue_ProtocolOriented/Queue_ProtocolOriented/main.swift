//
//  main.swift
//  Queue_ProtocolOriented
//
//  Created by chang sic jung on 10/10/2018.
//  Copyright © 2018 chang sic jung. All rights reserved.
//

import Foundation

var myQueue = Queue<Int>()

myQueue = [1,2,3,4,5] 
print("컬렉션 타입을 구현했으니 서브 스크립트를 사용한 큐의 4번째 값 접근 가능! : \(myQueue[3])") 
myQueue[3] = 8 // 수정
print("컬렉션 타입을 구현했으니 큐의 4번째 값 접근해서 수정도 가능!! : \(myQueue[3]) ")

// Sqeunce 프로토콜 구현부분 모두 삭제한 상태.
print(" \n Squence 프로토콜 구현부분 모두 삭제한 상태 ")
print(" Collection 프로토콜 구현 만으로 for 반복문에 사용할 수 있는지 확인 해보자. ")
for i in myQueue {
    print(i)
}


/*
for i in 1...5{
    myQueue.enqueue(element: i)
}
print(myQueue)
*/


