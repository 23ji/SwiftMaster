//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


//: # 큐(Queue/대기열)의 종류
//: ### 1)메인큐
//메인큐 = 메인쓰레드("쓰레드1번"을 의미), 한개뿐이고 Serial큐

let mainQueue = DispatchQueue.main




//: ### 2) 글로벌큐
// 6가지의 Qos를 가지고 있는 글로벌(전역) 대기열

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()  // 디폴트 글로벌큐
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)
let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)





//: ### 3) 프라이빗(커스텀)큐
//기본적인 설정은 Serial, 다만 Concurrent설정도 가능


let privateQueue = DispatchQueue(label: "com.inflearn.serial")

// 🍑 이렇게 커스텀으로 동시 큐 만들수도 있음
// 🍑
let concurrentQueue = DispatchQueue(label: "serial", attributes: .concurrent)




sleep(5)

PlaygroundPage.current.finishExecution()

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
