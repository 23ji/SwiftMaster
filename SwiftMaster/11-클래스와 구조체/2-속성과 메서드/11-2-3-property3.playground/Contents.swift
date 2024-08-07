import UIKit



/*:
 ## 3) 타입속성(Type Properties)
 * 타입 속성(Type Properties)
 ---
 */
// static(고정적인/고정된)이라는 키워드를 추가한 저장 속성


class Dog {
    
    static var species: String = "Dog"
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }

}


let dog = Dog(name: "초코", weight: 15.0)
dog.name
dog.weight




//dog.         // =====> 인스턴스에서 .(점)을 찍어도 속성으로 보이지 않음


Dog.species    // ====> 반드시 타입(형식)의 이름으로 접근해야함


//:> 저장 속성, 계산 속성 2가지 모두 타입속성이 될 수 있음

/*:
---
* 1) 저장 타입(형식) 속성
---
*/

class Circle {
    
    // (저장) 타입 속성 (값이 항상 있어야 함)
    static let pi: Double = 3.14
    static var count: Int = 0   // 인스턴스를 (전체적으로)몇개를 찍어내는지 확인
    
    // 저장 속성
    var radius: Double     // 반지름
    
    // 계산 속성
    var diameter: Double {     // 지름
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    // 생성자
    init(radius: Double) {
        self.radius = radius
        //Circle.count += 1
    }
    
}


//var circle1 = Circle(radius: 2)   // 인스턴스를 +1 개 찍어냈다.
//Circle.count
//
//var circle2 = Circle(radius: 3)   // 인스턴스를 +1 개 찍어냈다.
//Circle.count



let a = Circle.pi

// Circle()     //이런식으로 인스턴스 생성을 안 했는데도 접근 가능



// 실제 사용 예시)

Int.max
Int.min


Double.pi




/*:
---
* 2) 계산 타입(형식) 속성
---
*/

class Circle1 {
    
    // 저장 타입 속성
    static let pi: Double = 3.14
    static var count: Int = 0
    
    
    // (계산) 타입 속성(read-only)
    static var multiPi: Double {
        return pi * 2 //🍑타입끼리는 접근 가능하기 때문에 Circel1.pi(정식 문법)라고 안쓰고 생략
    }
    
    // 저장 속성
    var radius: Double     // 반지름
    
    
    // 생성자
    init(radius: Double) {
        self.radius = radius
         //🍑 만약 여기에 pi 쓰려면 Circle1.pi 이렇게 써야함 -> 생성자는 인스턴스에 속해있으니까
    }
    
}




let b = Circle1.multiPi


// 파이(3.14..)에 2배를 한 숫자가 만약, 많이 사용된다면
// 위와 같은 형태를 생각해 볼 수 있음

// 단순히, 계산 타입 속성도 가능하다는 것을 살펴보기 위한 예시


/*:
---
* 타입 속성의 메모리 구조의 이해
---
*/
/**================================================================================
 - 저장 타입 속성
 - 일반 저장속성은 인스턴스를 생성할때, 생성자에서 모든 속성을 초기화를 완료.
   그리고, 해당 저장 속성은 각 인스턴스가 가진 고유한 값임
 - 하지만, 저장 타입(형식) 속성은 생성자가 따로 없기때문에, 타입 자체(유형 그 자체)에
   속한 속성이기 때문에 항상 기본값이 필요. 생략할 수 없음

 - 지연 속성의 성격을 가짐 ⭐️
 - 저장 타입속성은 기본적으로 지연 속성 (속성에 처음 접근하는 순간에 초기화됨)이지만, lazy라고 선언할 필요는 없음
   (참고: 여러 스레드에서 동시에 액세스하는 경우에도 한 번만 초기화되도록 보장됨. Thread-Safe)
 ================================================================================**/
/*:
---
* 주의점
---
*/
/**====================================================================
 - 타입 속성(Type Properties) ====> 클래스, 구조체, (열거형)에 모두 추가할 수 있음

 - let 또는 var 둘다 선언 가능
 - 타입 속성은 특정 인스턴스에 속한 속성이 아니기 때문에 인스턴스 이름으로는 접근불가
====================================================================**/
//:> 인스턴스 내에서도 접근하려면 타입이름 + 속성으로 써야 접근 가능함

class Circle2 {
    
    // 저장 타입 속성
    static let pi: Double = 3.14
    static var count: Int = 0
    
    
    // 저장 속성
    var radius: Double     // 반지름
    
    
    // 생성자
    init(radius: Double) {
        self.radius = radius
        Circle2.count += 1
    }
    
    
    // 넓이 구하기 ==>  원의 넓이 공식 ==> 파이 X 반지금 제곱
    func getArea() -> Double {
        
                   // 타입이름으로 접근해야함
        let area = Circle2.pi * radius * radius        // 내부 인스턴스에서도 타입 속성에 접근할때 주의
        return area
    }

}



let c1 = Circle2(radius: 3)
c1.getArea()
Circle2.count


let c2 = Circle2(radius: 2)
Circle2.count


//let c3 = Circle2(radius: 2)
//Circle2.count



/**=======================================================================
 - 어떤 경우에 타입 속성을 선언해야 하나?
 - 모든 인스턴스가 동일하게 가져야 하는 속성이거나(해당 타입의 보편적인 속성),
   모든 인스턴스가 공유해야하는 성격에 가까운 이어야 함(예에서 확인)


 - 상속에서 재정의(overriding)
 
 - 1) 저장 타입 속성 ===> 상속에서, 하위클래스에서 재정의 불가능(class키워드 안됨)
                      (인스턴스의 경우도 저장 속성은 고유의 틀이기 때문에 건드릴 수 없음)
 - 2) 계산 타입 속성 ===> 상속에서, 상위클래스에서 class키워드를 붙인 경우, 재정의 가능


 - class키워드(계산 타입 속성만) ⭐️
 - 상속이 있는 경우, 계산 타입 속성에서는 static대신 class키워드를 사용
   (===>static과 동일한 역할)하면 재정의 가능한 속성이 됨
========================================================================**/








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
