//
//  SomePrivateClass.swift
//  AccessControl
//
//  Created by Allen H on 2021/04/12.
//

import Foundation

// 타입을 private으로 선언하면 아무곳에서도 사용할 수 없기 때문에 의미가 없음
// ===> 따라서 fileprivate으로 동작 ⭐️

private class SomePrivateClass {                    // 명시적인 private 선언
    open var someOpenProperty = "SomeOpen"
    public var somePublicProperty = "SomePublic"
    var someInternalProperty = "SomeInternal"
    
    // 실제 fileprivate 처럼 동작 ⭐️ (공식문서 오류) 타입은 private 해봤자 의미 없음, 동작 안함, fileprivate로 동작함
    var someFilePrivateProperty = "SomeFilePrivate"
    private var somePrivateProperty = "SomePrivate"
}



class SomePrivateControlClass {
    // filepravate 또는 private으로만 선언 가능
    fileprivate let controlProperty = SomePrivateClass() // 🍑 SomePri~가 fileprivate이기 때문에 그냥 let~ 쓰면 오류. fileprivate 붙여줘야함
    
    func controlFunction() {
        let someFilePrivate = SomePrivateClass()
        print(someFilePrivate.someOpenProperty)        // fileprivate으로 동작
        print(someFilePrivate.somePublicProperty)      // fileprivate으로 동작
        print(someFilePrivate.someInternalProperty)    // fileprivate으로 동작
        print(someFilePrivate.someFilePrivateProperty) // 같은 파일이기에 접근가능
        //print(controlProperty.somePrivateProperty)   // 접근 불가
    }
}
