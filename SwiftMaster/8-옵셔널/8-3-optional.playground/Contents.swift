import UIKit

/*:
 ## 옵셔널 체이닝(Chaining)
* 옵셔널 체이닝 (Optional Chaining) 문법
---
*/
// 옵셔널타입에 대해 접근연산자를 사용하는 방법

class Dog {
    var name: String?
    var weight: Int
    
    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다.")
    }
    
    func layDown() {
        print("누웠습니다.")
    }
}


class Human {
    var dog: Dog?  // 🍑 (1)
}


// 옵셔널타입에 대해, "접근연산자"를 사용할때, ?(물음표)를 붙여서, 앞의 타입이 값이 nil을 가질 수도 있음을 표시


var choco = Dog(name: "초코", weight: 15)
choco.name
choco.sit()
//choco?.name = "초코얌"
//choco?.sit()              // Optional("초코얌")가 앉았습니다.



//var human = Human()
//human.dog = choco
//human.dog?.name // 🍑 위 (1) optional Dog을 채택했기 때문에 / 맨 뒤에는 ? 안붙여도 됨
//print(human.dog?.name)     // Optional("초코얌")



var human2: Human? = Human()
human2?.dog = choco
human2?.dog?.name
print(human2?.dog?.name)      // Optional("초코얌")



/**============================================================================
- 옵셔널 체이닝 (옵셔널 타입에 대해, 접근연산자 호출하는 방법)
- 1) 옵셔널체이닝의 결과는 항상 옵셔널이다.
- 2) 옵셔널체이닝에 값 중에서 하나라도 nil을 리턴한다면, 이어지는 표현식을 평가하지 않고 nil을 리턴
===============================================================================**/


/*:
---
* 실제 사용시에는 결국, Unwrapping해서 사용해야함
---
*/

// 1) 앞의 옵셔널타입에 값이 있다는 것이 확실한 경우

print(human2!.dog!.name)          // name 자체가 옵셔널타입이기 때문에 Optional("초코얌")
print(human2!.dog!.name!)
print(human2!.dog!.weight)        // weight 자체는 옵셔널타입이 아니기 때문에   15



// 2) if let 바인딩

if let name = human2?.dog?.name {    // Optional("초코얌")
    print(name)                      // 초코얌
}



// 3) Nil-Coalescing 연산자

var defaultName = human2?.dog?.name ?? "멍탱구리"
print(defaultName)






/*:
 ## 활용 예시(헷갈릴 수 있는 부분 정리)
* 1) 옵셔널 체이닝 - 함수 관련 표기법
---
*/
class Cat {
    var name: String?
    
    var myMaster: (() -> Person?)?
    
    init(aFunction: @escaping () -> Person?) {
        self.myMaster = aFunction // 🍑 함수가 변수에 저장되면서 함수의 흐름(스택프레임)을 벗어나기 때문에 클로저를 사용함 => @escaping 키워드 필수 !
    }
}


class Person {
    var name: String?
}


// 함수를 정의
func meowmeow() -> Person? {
    let person = Person()
    person.name = "Jobs"
    return person
}


// 예제를 위한 예제임 ⭐️

                           // 정의한 함수를 할당
var cat: Cat? = Cat(aFunction: meowmeow)


var name = cat?.myMaster?()?.name               // Optional("Jobs")
// 🍑 cat? -> Cat? 이기 때문에 cat이 있을 수도 없을 수도 있다.
// myMaster? -> (() -> Person?)? 이기 때문에 함수가 있을 수도 없을 수도 있다.
// ()? -> meowmeow() -> Person? 이기 때문에 결과값 person이 있을 수도 없을 수도 있다.

print(name)



/*:
---
* 2) 옵셔널 체이닝 - 딕셔너리 관련 표기법
---
*/
class Library1 {
    var books: [String: Person]?
}


var person1 = Person()
person1.name = "Jobs"
print(person1.name)


var person2 = Person()
person2.name = "Musk"
print(person2.name)



var library = Library1()
library.books = ["Apple": person1, "Tesla": person2]



library.books?["Apple"]?.name
library.books?["Tesla"]?.name

// 1. books?  ====> 딕셔너리 자체가 없을 수 있음을 의미
// 2. books?["Apple"]?  ====> 딕셔너리의 결과값이 없을 수 있음을 의미



// 실제로 사용하려면? ===> 옵셔널 벗기고 사용해야함

if let name = library.books?["Apple"]?.name {
    print("이름:", name)
}




/*:
---
* 3) 옵셔널 체이닝에서 함수의 실행은?
---
*/
/**=================================================================
- 옵셔널 타입에 접근해서 사용하는 함수는 앞의 타입을 벗기지 않아도 사용가능 함.
  (함수자체가 옵셔널 타입은 아니기 때문에 함수를 벗겨서 사용할 필요없음)
 
- 1) 함수가 리턴형이 없는 경우
     (1) 타입에 값이 있으면 함수실행
     (2) 타입에 값이 없으면 nil
 
- 2) 함수가 리턴형이 있는 경우
     (1) 타입에 값이 있으면 옵셔널 리턴 타입으로 반환 (원래 리턴형이 옵셔널이 아니더라도)
     (2) 타입에 값이 없으면 nil로 반환
====================================================================**/


var bori: Dog? = Dog(name: "보리", weight: 20)

bori?.layDown()          // ⭐️ 앞의 타입이 옵셔널이라고 해서 메서드가 실행이 안되는 것은 아님
bori?.sit()              // Optional("보리")가 앉았습니다.


bori = nil
bori?.layDown()          // 타입의 값이 nil이면, 함수가 실행이 되지 않고 nil을 반환


// 사실 결론은 간단. 옵셔널 체이닝에서 함수(메서드 실행)의 경우 크게 신경을 쓰지 않고 호출하면 됨
// (옵셔널이라는 것은 변수 안의 값에 대한 문제일 뿐)






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
