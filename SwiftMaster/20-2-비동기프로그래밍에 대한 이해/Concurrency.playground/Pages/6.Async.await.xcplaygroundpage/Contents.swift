//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


//: ### 작업을 오랫동안 실행하는 비동기 함수가 있다고 가정

func longtimePrint(completion: @escaping (Int) -> Void) {
    DispatchQueue.global().async {
        print("프린트 - 1")
        sleep(1)
        print("프린트 - 2")
        sleep(1)
        print("프린트 - 3")
        sleep(1)
        print("프린트 - 4")
        sleep(1)
        print("프린트 - 5")
        completion(7)
    }
}



//: # Async/await의 도입
//: ### Swift 5.5버전 이후 ~
//:> 콜백함수 처리방식의 단점
// 여러개의 비동기함수를 이어서 처리할때, 코드의 처리가 불편
// 비동기함수의 일이 종료되는 시점을 연결하기 위해, 끊임없는 콜백함수의 연결이 필요
// 코드는 계속 들여쓰기.. 들여쓰기.. 들여쓰기..



func linkedPrint(completion: @escaping (Int) -> Void) {
    longtimePrint { num in
        // 코드처리
        longtimePrint { num in
            // 코드처리
            longtimePrint { num in
                // 코드처리
                longtimePrint { num in
                    // 코드처리
                    completion(num)    // 모든 비동기함수의 종료시점을 알려줌
                }
            }
        }
    }
}



//:> Async/await 방식의 도입 / Swift 5.5 ~
// 콜백함수를 계속 들여쓰기 할 필요없이 반환시점을 기다릴수 있어, 깔끔한 코드의 처리가 가능



// Async/await 함수의 설계
// 내부에 따로 DispatchQueue로 보낼 필요는 없음

// 🍑 리턴형으로 설계시 async 키워드 붙이기 !
func longtimeAsyncAwait() async -> Int {
    print("프린트 - 1")
    sleep(1)
    print("프린트 - 2")
    sleep(1)
    print("프린트 - 3")
    sleep(1)
    print("프린트 - 4")
    sleep(1)
    print("프린트 - 5")
    return 7
}



// Async/await 함수의 사용
// 🍑 실행시 await 붙이기 !
func linkedPrint2() async -> Int {
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    return 7
}







sleep(7)
PlaygroundPage.current.finishExecution()


//참고 https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md

//: [Next](@next)
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
