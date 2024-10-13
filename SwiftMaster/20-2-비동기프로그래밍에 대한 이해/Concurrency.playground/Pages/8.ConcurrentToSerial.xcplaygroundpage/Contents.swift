//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # 동시큐에서 직렬큐로 보내기
//: ### Thread-safe하지 않을때, 처리하는 방법
// 배열은 여러쓰레드에서 동시에 접근하면 문제가 생길 수 있다.

// 🍑 빈 배열 생성
var array = [String]()
// 🍑 직렬 큐 생성
let serialQueue = DispatchQueue(label: "serial")


for i in 1...20 {
    DispatchQueue.global().async {
        print("\(i)")
        //array.append("\(i)")    //  <===== 동시큐에서 실행하면 동시다발적으로 배열의 메모리에 접근
        // 🍑 아래 코드가 없다면 스레드 세이프 하지 않게 됨
        serialQueue.async {        // 올바른 처리 ⭐️
            array.append("\(i)")
        }
    }
}




// 5초후에 배열 확인하고 싶은 코드 일뿐...
// 🍑 지금으로 부터 5초 뒤에 실행하는 코드
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    print(array)
    //PlaygroundPage.current.finishExecution()
}



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
