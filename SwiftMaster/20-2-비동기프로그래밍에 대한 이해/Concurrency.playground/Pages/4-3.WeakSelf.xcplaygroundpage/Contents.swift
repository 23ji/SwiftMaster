//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 클로저의 강한 참조 주의
//: ### 강한참조의 경우 주의해서 사용해야함
//:>강한 참조
// 강한 참조가 일어나고, (서로가 서로를 가르키는) 강한 참조 사이클은 일어나지 않지만
// 생각해볼 부분이 있음


class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)                // 🍑 강한 참조 중
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}


//localScopeFunction()

//글로벌큐에서 출력하기: 뷰컨
//뷰컨 메모리 해제
/**=======================================================
 - (글로벌큐)클로저가 강하게 캡처하기 때문에, 뷰컨트롤러의 RC가 유지되어
 - 뷰컨트롤러가 해제되었음에도, 3초뒤에 출력하고 난 후 해제됨
 - (강한 순환 참조가 일어나진 않지만, 뷰컨트롤러가 필요없음에도 오래 머무름)

 - 그리고 뷰컨트롤러가 사라졌음에도, 출력하는 일을 계속함
=========================================================**/

//:> 약한 참조 - 클로저 부분에서 학습했던 내용

class ViewController1: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        // 🍑 약한 참조로 weakSelf가 nil이라 return됨
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            sleep(3)
            print("글로벌큐에서 출력하기: \(weakSelf.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction1() {
    let vc = ViewController1()
    vc.doSomething()
}


localScopeFunction1()

//뷰컨 메모리 해제
//글로벌큐에서 출력하기: nil
/**=======================================================
 - 뷰컨트롤러를 오래동안 잡아두지 않음
 - 뷰컨트롤러가 사라지면 ===> 출력하는 일을 계속하지 않도록 할 수 있음
   (if let 바인딩 또는 guard let 바인딩까지 더해서 return 가능하도록)
=========================================================**/



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
