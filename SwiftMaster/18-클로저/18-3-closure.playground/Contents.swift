import UIKit

/*:
 ## 클로저의 사용
 * 클로저를 왜 사용하는가? - 1
 ---
 */
// 1) (클로저를 파라미터로 받는 함수)정의

func closureParamFunction(closure: () -> ()) {
    print("프린트 시작")
    closure()
}


// 파라미터로 사용할 함수/클로저를 정의

func printSwiftFunction() {          // 함수를 정의
    print("프린트 종료")
}


let printSwift = { () -> () in      // 클로저를 정의
    print("프린트 종료")
}



// 함수를 파라미터로 넣으면서 실행 (그동안에 배운 형태로 실행한다면)

closureParamFunction(closure: printSwiftFunction)

closureParamFunction(closure: printSwift)





// 2) 함수를 실행할때 클로저 형태로 전달 (클로저를 사용하는 이유)


closureParamFunction(closure: { () -> () in
    print("프린트 종료")           // 본래 정의된 함수를 실행시키면서, 클로저를 사후적으로 정의 가능
})                              // (활용도가 늘어남)



closureParamFunction(closure: { () -> () in
    print("프린트 종료 - 1")
    print("프린트 종료 - 2")
})



/*:
 ---
 * 클로저를 왜 사용하는가? - 2
 ---
 */

// 1) (클로저를 파라미터로 받는 함수)정의

func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}




// 2) 함수를 실행할 때 (클로저 형태로 전달)


// 🍑 아래의 n, num은 파라미터 이름!, 이름은 개발자가 원하는 대로 정의 가능
closureCaseFunction(a: 5, b: 2, closure: { (n) in    // 사후적 정의
    print("이제 출력할께요: \(n)")
})



closureCaseFunction(a: 5, b: 2) {(number) in      // 사후적 정의
    print("출력할까요? \(number)")
}


closureCaseFunction(a: 5, b: 3) { (number) in      // 사후적 정의
    print("출력")
    print("출력")
    print("출력")
    print("값: \(number)")
}




/*:
 ---
 * 여러가지 예시로 정확하게 이해하기
 ---
 */

let print1 = {
    print("1")
}

let print2 = {
    print("2")
}

let print3 = {
    print("3")
}


// 함수의 정의

func multiClosureFunction(closure1: () -> Void, closure2: () -> Void) {
    closure1()
    closure2()
}





// 함수의 실행

multiClosureFunction(closure1: print1, closure2: print2)

multiClosureFunction(closure1: print2, closure2: print3)


multiClosureFunction(closure1: {
    print("1")
}, closure2: {
    print("2")
})



// 함수의 정의

func performClosure(closure: () -> ()) {
    print("시작")
    closure()
    print("끝")
}



// 함수의 실행

performClosure(closure: {
    print("중간")
})







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
