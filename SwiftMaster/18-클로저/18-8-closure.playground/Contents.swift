import UIKit

/*:
 ## 객체 내에서 클로저의 사용
 * 일반적인 클로저의 사용(객체 내에서의 사용, self키워드)
 ---
 */
/**======================================================================
 - 클로저 내에서 객체의 속성 및 메서드에 접근 시에는 "self키워드"를 반드시 사용해야함
 - (강한 참조를 하고 있다는 것을 표시하기위한 목적) ===> 여기서는 Dog의 RC를 올리는 역할 +1

 - 1) self.name
 - 2) [self]  =====> Swift 5.3이후
 
 - 구조체의 경우, self를 생략하는 것도 가능 (Swift 5.3이후) ⭐️
=========================================================================**/


class Dog {
    var name = "초코"

    func doSomething() {
        // 비동기적으로 실행하는 클로저
        // 해당 클로저는 오래동안 저장할 필요가 있음 ==> 새로운 스택을 만들어서 실행하기 때문
        // 🍑 아래 예시는 "사이클"은 일어나고 있지 않지만 "강한 참조":는 일어나고 있는 상태!!!
        //1) 예시
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
        //2) 예시
//        DispatchQueue.global().async { [self] in
//            print("나의 이름은 \(name)입니다.")
//        }
        
    }
}


var choco = Dog()
choco.doSomething()


// 클로저가 choco인스턴스에 대해 강한 참조는 하지만 (RC + 1)
// 실제 강한 참조 사이클을 일으키진 않음

/*:
 ---
 * 클로저 캡처 리스트 - Strong Reference Cycle(강한 참조 순환) 해결
 ---
 */
/**===================================================================
 - 클로저는 기본적으로 캡처 현상이 발생

 - 클로저와 인스턴스가 강한참조로 서로를 가르키고 있다면(Strong Reference Cycle),
   메모리에서 정상적으로 해제되지 않고, 메모리 누수 현상이 발생

 - 캡처리스트 내에서, 약한 참조 또는 비소유 참조를 선언해서 문제해결
===================================================================**/
//:> 클로저의 강한 참조 해결: 캡처 리스트 + 약한/비소유 참조 선언
// 🍑 위 코드에서 아래와 같이 수정하면 액한 참조로 수정하는 것!!!

// 🍑 DispatchQueue.global().async { [weak self] in
//    print("나의 이름은 \(self?.name)입니다.")
//}

/*:
 ---
 * 캡처리스트 + weak/unowned
 ---
 */
// ⭐️ 클로저를 객체 내에서 사용할때는 대부분 weak과 함께 사용한다고 보면 됨


class Person {
    let name = "홍길동"
    
    func sayMyName() {
        print("나의 이름은 \(name)입니다.")
    }
    
    // 🍑 강한 참조
    func sayMyName1() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
    
    // 🍑 약한 참조 / 출력값 옵셔널
    func sayMyName2() {
        DispatchQueue.global().async { [weak self] in
            print("나의 이름은 \(self?.name)입니다.")
        }
    }
    
    // 🍑 약한 참조 + 가드렛 바인딩 / 일반적으로 약한 참조 추출 시에 가드문 많이 사용 / weakSelf라는 상수에 주로 담음
    func sayMyName3() {
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }   // 가드문 처리 ==> 객체없으면 일종료
            print("나의 이름은 \(weakSelf.name)입니다.(가드문)")
        }
    }
}


let person = Person()

person.sayMyName()
person.sayMyName1()
person.sayMyName2()
//person.sayMyName3()








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
