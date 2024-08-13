import UIKit

/*:
 # Part18 - 클로저(Closure)
 */
/*:
 ## 클로저 - 이름이 없는(익명) 함수
 * 함수의 타입에 대한 표기 (복습)
 ---
 */
// 함수의 타입 표기법

let functionA: (String) -> String      // 1)파라미터 문자열, 2)리턴형 문자열

let functionB: (Int) -> ()             // 1)파라미터 정수, 2)리턴형 없음

let functionC: (String) -> Void        // 1)파라미터 문자열, 2)리턴형 없음




/*:
 ---
 * 기존의 함수의 형태와 클로저의 형태 비교
 ---
 */
// 함수의 정의

func aFunction(str: String) -> String {
    return "Hello, \(str)"
}



// 클로저의 형태

let _ = {(str: String) -> String in
    return "Hello, \(str)"
}



//:>  생각의 전환 ➞ 중괄호는 클로저(함수)이다!

let aClosureType = { () -> () in              // 변수에 담아서 호출하는 것도 가능
    print("안녕")
}


// 🍑 void인 경우에 아래 처럼 쓸 수도 있음, 이 때 클로저인 것을 인지할 수 있어야 한다!
//let aClosureType = {               // 변수에 담아서 호출하는 것도 가능
//    print("안녕")
//}


let aClosureType1 = { print("안녕") }         // () -> () //🍑 1번 조건 변수에 할당 가능!



aClosureType1() //🍑 () 함수의 실행!




/*:
 ---
 * 함수를 1급객체(First-class Object)로 취급
 ---
 */
/**================================================
 - 함수를 1급 객체로 취급
 
 - 1) 함수를 변수에 할당할 수 있다.
 - 2) 함수를 파라미터로 전달이 가능하다.
 - 3) (함수에서) 함수를 반환할 수 있다. (리턴 가능)
 ==================================================**/



func aFunction1(_ param: String) -> String {
    return param + "!"
}


func aFunction2(name: String) -> String {
    return name + "?!??"
}



// 함수를 변수에 할당가능(변수가 함수를 가르키게 됨)

var a: (String) -> String = aFunction1

a("안녕")
// 🍑 변수에 담아서 사용할 때는 파라미터 이름이 필요 없다! ex : a(param: "안녕") <- 이러면 오류임


a = aFunction2
// 🍑 aF1이랑 aF2랑 타입이 완전 동일해서 a에 aF2도 할당 가능한 것임!
// 함수 할당도 타입이 같아야 가능하다
a("hello")




// 함수(클로저)를 변수에 할당해서

let closureType = { (param: String) -> String in         // 클로저 리터럴
    return param + "!" // 🍑 같은 타입끼리만 + 가능하기 때문에 param이 문자인거 타입 추론 가능
}



// 사용(실행)

closureType("스티브")







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
