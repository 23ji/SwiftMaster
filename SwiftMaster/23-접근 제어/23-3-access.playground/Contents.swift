import UIKit

/*:
 ## 상속과 확장의 접근 제어
 * 상속 관계(Subclassing)의 접근 제어
 ---
 */
/**===========================================================================
- 1)타입 관련: 상속해서 만든 서브클래스는 상위클래스보다 더 높은 접근 수준을 가질 수는 없음
- 2)멤버 관련: 동일 모듈에서 정의한 클래스의 상위 멤버에 접근가능하면, (접근 수준 올려서) 재정의(override)도 가능
 =============================================================================**/

// 🍑 클래스 : 하위 수준 <= 상위 수준 / 멤버 : 하위 수준 (<-접근 가능하면 상관 없음->) 상위 수준
public class A {
    fileprivate func someMethod() {}
}


// public이하의 접근 수준만 가능(public/internal/fileprivate)
internal class B: A {
    override internal func someMethod() {   // 접근 수준 올려서 재정의 가능 ⭐️
        super.someMethod()                  // (더 낮아도) 모듈에서 접근가능하기 때문에 호출가능
    }
}


/*:
 ---
 * 확장(Extension)의 접근 제어
 ---
 */
// 기본법칙 - 원래 본체와 동일한 접근 수준을 유지하고, 본체의 멤버에는 기본적인 접근 가능

public class SomeClass {
    private var somePrivateProperty = "somePrivate"
}


extension SomeClass {   // public으로 선언한 것과 같음
    func somePrivateControlFunction() {
        somePrivateProperty = "접근가능"
    }
}






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
