import UIKit

/*:
 ## Defer문
 * 할일을 미루는 defer문에 대한 이해
 ---
 */
// defer문은 코드의 실행을 스코프가 종료되는 시점으로 연기시키는 문법
// 일반적인 사용은, 어떤 동작의 마무리 동작을 특정하기 위해서 사용 (정리의 개념)


func deferStatement1() {
    
    defer {
        print("나중에 실행하기") // 🍑  나의 중괄호 내에서 가장 마지막으로 순서 미룸
    }
    
    print("먼저 실행하기")
}

deferStatement1()






func deferStatement2() {
    
    if true {
        print("먼저 실행하기")
        return // 🍑deferStatement2를 벗어남
    }
    
    defer {                   // 디퍼문이 호출되어야, 해당 디퍼문의 실행이 예약되는 개념
        print("나중에 실행하기")
    }
}

deferStatement2()






// 등록한 역순으로 실행  ====> 일반적으로 하나의 디퍼문만 사용하는 것이 좋음

func deferStatement3() {
    defer {
        print(1)
    }
    defer {
        print(2)
    }
    defer  {
        print(3)
    }
}

deferStatement3()





// 어떻게 실행될까?

for i in 1...3 {
    defer { print ("Defer된 숫자?: \(i)") }
    print ("for문의 숫자: \(i)")
}

// 🍑  반복문에서는 다음 주기가 넘어가기 전에 defer문이 실행된다





//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
