 import UIKit


/*:
## 4) 생성자(Initializer)
*/
/*:
 ---
 * 구조체 vs 클래스 생성자(Initializer)
 ---
 */
/**=======================================
 - (지정)생성자   <=====>  편의 생성자


 [구조체의 생성자]
 - 1) 지정 생성자, (자동제공되는 멤버와이즈생성자)
 - 2) 실패가능생성자


 [클래스의 생성자]
 - 1) 지정 생성자
 - 2) 편의 생성자  (상속과 관련)
 - 3) 필수 생성자  (상속과 관련)
 - 4) 실패가능생성자
=========================================**/



/*:
## 구조체 생성자
*/
/*:
---
* 여러개의 지정 생성자 구현
---
*/
//:> 구조체나 클래스, 둘다 아래처럼 구현 가능(오버로딩을 지원하므로)
// 그렇지만, 이런 방식이 올바른 구현 방법은 아님
//🍑 이렇게 구현시 상속했을 때 복잡, 오류 날 확률 높아지고, 수정시에도 불편함

struct Color {
    let red, green, blue: Double
    
    init() {      // 기본 생성자. 기본값을 설정하면 자동으로 제공됨
        red = 0.0
        green = 0.0
        blue = 0.0
    }

    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}



/*:
---
* 구조체(값타입)의 지정생성자의 구현
---
*/
// 🍑 위 방법보다 이 방식이 더 올바르다고 볼 수 있다, 중복성 감소, 오류 방지
struct Color1 {
    let red, green, blue: Double
    
    init() {      // 구조체는 다른 생성자를 호출하는 방식도 가능 ⭐️
        //red = 0.0
        //green = 0.0
        //blue = 0.0
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }

    init(white: Double) {    // 구조체는 다른 생성자를 호출하는 방식도 가능 ⭐️
        //red   = white
        //green = white
        //blue  = white
        self.init(red: white, green: white, blue: white)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}


// 값타입(구조체)의 경우 자체 지정생성자 작성할 때
// 생성자 내에서 self.init(...)를 사용하여 다른 이니셜라이저를 호출하도록 할 수 있음



/*:
## 클래스 생성자
*/
/*:
---
* 클래스의 지정(Designated) vs 편의 생성자(Convenience)
---
*/

class Color2 {
    let red, green, blue: Double
    
    convenience init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0)
        //self.init(white: 0.0)
    }

    convenience init(white: Double) {
        //red   = white
        //green = white
        //blue  = white
        self.init(red: white, green: white, blue: white)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}

/**========================================================================
 - 일단 편의 생성자는 편리하게 생성하기 위한 서브(Sub)생성자라고 보면됨(메인이 아닌)
 - ===> (메인) 지정 생성자에 의존하는 방식 (지정 생성자 호출)

 - 지정 생성자는 모든 속성을 초기화 해야함
 - 편의 생성자는 모든 속성을 초기화 할 필요가 없음(편의적 성격)

  ⭐️
 - 클래스는 상속을 지원하므로, 변수가 여러개 이고,
 - 여러 지정 생성자를 지원했을때 상속 관계에서 개발자가 실수할 수 있는 여러가지 가능성이 있음.
 - 따라서, 초기화 과정을 조금 간편하게 만들고,
 - 상속관계에서 개발자가 실수 할 수 있는 여러가능성을 배제하기 위한 생성자임

 - 반대로 말하자면 모든 속성을 초기화하지 않는다면 ===> 편의생성자로 만드는 것이 복잡도나 실수를 줄일 수 있음
 - 결국, 생성자의 가능한 중복을 없애고 다른 지정 생성자를 호출하는 패턴으로 구현해야 함
 ==========================================================================**/

//:> (이미 모든 속성을 초기화하는 지정생성자가 있다면) 모든 속성을 초기화하지 않는 경우 편의생성자로 구현을 권장

/*:
---
* 클래스의 상속과  지정/편의 생성자 사용 예시
---
*/
class Aclass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {    // 지정생성자 - 모든 저장 속성 설정
        self.x = x
        self.y = y
    }
    
    convenience init() {     // 편의생성자 - (조금 편리하게 생성) 모든 저장 속성을 설정하지 않음
        self.init(x: 0, y: 0)
    }
}


// 상속이 일어나는 경우 ⭐️

class Bclass: Aclass {
    
    var z: Int
    
    init(x: Int, y: Int, z: Int) {    // 실제 메모리에 초기화 되는 시점
        self.z = z                 // ⭐️ (필수)
        //self.y = y               // 불가 (메모리 셋팅 전)
        super.init(x: x, y: y)     // ⭐️ (필수) 상위의 지정생성자 호출
        //self.z = 7
        //self.y = 7
        //self.doSomething()
    }
    
    convenience init(z: Int) {
        //self.z = 7     //==========> self에 접근불가
        self.init(x: 0, y: 0, z: z)
        //self.z = 7
    }
    
    convenience init() {
        self.init(z: 0)
    }
    
    func doSomething() {
        print("Do something")
    }
}



let a = Aclass(x: 1, y: 1)
let a1 = Aclass()


let b = Bclass(x: 1, y: 1, z: 1)
let b1 = Bclass(z: 2)
//b1.x
let b2 = Bclass()


/*:
---
* 클래스의 상속과 지정 생성자와 편의 생성자의 호출 규칙
---
*/
/**===============================================================================
 - 생성자 위임 규칙(Initializer Delegation)

 - (1) 델리게이트 업(Delegate up)
 -     서브클래스의 지정생성자는 수퍼 클래스의 지정생성자를 반드시 호출해야함
 - (2) 델리게이트 어크로스(Delegate across)
 -     편의생성자는 동일한 클래스에서 다른 이니셜 라이저를 호출해야하고, 궁극적으로 지정생성자를 호출해야함


 - ===> 인스턴스 메모리 생성에 대한 규칙이 존재함(규칙을 안지키면 인스턴스가 올바르게 초기화되지 않음)
=================================================================================**/


/*:
---
* 클래스의 상속과 초기화 과정의 이해(2단계 초기화 과정) - 그림으로 이해 ⭐️
---
*/
/**==================================================================
 - 인스턴스의 모든 저장 속성이 초기값을 가지면 완전히 초기화된 것임(생성 완료)

 - 각 단계에서 선언된 저장속성은 각 해당 단계에서 초기값을 가져야 함
 - ===> 그리고나서 수퍼클래스로 생성 위임(델리게이트 업)이 일어나야 함


 - [1단계] (필수사항)
 - 해당 클래스에서 선언한 모든 저장속성에 값이 있는지 확인하여 메모리 초기화
 - 상위 지정생성자로 델리게이트 업하여 (해당 단계의) 모든 저장 속성의 메모리 초기화
 - (최종적으로) Base 클래스가 모든 저장 속성에 값이 있는지 확인하면
 - 저장속성이 완전히 초기화 된 것으로 간주되어 인스턴스가 생성 완료

 
 - [2단계] (선택사항)
 - 인스턴스의 생성 완료 후,
 - 상속관계의 맨 위에서 아래로 내려가면서, 호출된 각각의 생성자가 인스턴스를 추가로 커스텀함
 - (커스텀의 의미: 새로운 값을 셋팅하거나 메서드 호출 등이 가능)
 - 메모리가 초기화가 완료된 후이므로
 - 이제 self 속성에 접근이 가능해지고, 속성을 수정하거나 인스턴스 메서드를 호출이 가능해짐
 =====================================================================**/








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
