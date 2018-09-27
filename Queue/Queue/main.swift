//
//  main.swift
//  Queue
//
//  Created by chang sic jung on 17/09/2018.
//  Copyright © 2018 chang sic jung. All rights reserved.
//

import Foundation

print("\n")
/*
var queueArray = QueueArray<String>() // 인스턴스 생성하구 제네릭 타입은 String
queueArray.enQueue("창식") // 큐 추가하구~ 제 이름입니다..^^
queueArray.enQueue("유정")
queueArray.enQueue("주혁")
print(queueArray) // 여기서 한번 출력 
queueArray.deQueue() // 가장 앞에 있는 큐 제거,
print(queueArray) // 출력

print("\n")


var queueLinkedlist = QueueLinkedList<String>()
queueLinkedlist.enQueue("창식")
queueLinkedlist.enQueue("유정")
queueLinkedlist.enQueue("주혁")
print(queueLinkedlist)
queueLinkedlist.deQueue()
print(queueLinkedlist)
*/
print("\n")

var queueBuffer = QueueRingBuffer<Int>(count: 7) // 크기가 7 인 RingBuffer 큐 생성.

for i in 1...7 { // 1 ~ 7 까지 큐에 값을 enQueue 합니다.
    queueBuffer.enQueue(i)
}
print(queueBuffer) // 요기서 한번 출력

for _ in 0..<3 { 
    // 이 시점에서 deQueue 해주지 않으면 배열이 가득 차서 enQueue 안되쥬? 
    // deQueue 3번 실행.
    queueBuffer.deQueue()
}
print(queueBuffer)

queueBuffer.enQueue(8) 
// 배열의 첫 인덱스로 돌아와서 8 을 입력하는 enQueue()
// 배열만 이럴 뿐이지 큐는 8이 끝에 있는 모양입니다. 
print(queueBuffer)

print("\n")
/*
var queueStack = QueueDoubleStack<String>() // 인스턴스 생성
queueStack.enQueue("창식") // 큐에 값 추가
queueStack.enQueue("유정")
queueStack.enQueue("주혁")
print(queueStack) // 요 시점에서 출력한번
queueStack.deQueue() 
// deQueue() 하면 LeftStack 으로 값 옮겨지고 마지막 값 제거하겠쥬?
print(queueStack) // 제거 잘 됬나 출력

print("\n")


let test = 0..<3
print(test)
 */


