import UIKit

/*:
 ## 오버플로우
* 오버플로우의 개념
---
*/
/**==============================================================
 [오버플로우(overflow)]
 - C언어나 Objective-C언어의 산술연산자에서는 값이 넘침(overflow)을 허락했지만
   (예를 들어, 8비트 값을 담을 수 있는 숫자에서 255를 넘어가면 다시 0으로 순환)
   스위프트에서는 오버플로우를 기본적으로 허락하지 않음 ===> 에러발생(크래시)
 - 오버플로우의 방향은 양(positive)의 방향, 음(nagative)의 방향을 모두 의미
 
 - 특정한 경우에, 특정패턴을 구현하기 위해 오버플로우를 허용하는 경우가 필요한데,
   이런 경우 활용을 위해 "오버플로우 연산자"를 마련해 놓았음
================================================================**/


UInt8.max   // UInt8(8비트의 값을 담을 수 있음)의 최대값 255 // 🍑 -> 1바이트 사용 가능
UInt8.min   // UInt8(8비트의 값을 담을 수 있음)의 최소값 0

//let num: UInt8 = 300


/*:
 ## 오버플로우 연산자
 * 스위프트의 3가지 오퍼플로우 연산자
 ---
 */
//:> 스위프트에서는 오버플로우 연산자 따로 존재
/**===========================
 [오버플로우 연산자]
 - &+ : 오버플로우 더하기 연산자
 - &- : 오버플로우 빼기 연산자
 - &* : 오버플로우 곱하기 연산자
 
 - 앰퍼샌드(&)기호가 붙어있음
=============================**/
 
// 🍑 평소에 딱히 쓸 일 없음
/*:
---
* 부호가 없는 경우(Unsigned)의 오버플로우
---
*/
/**=========================
 - UInt8타입의 범위: 0 ~ 255 // 🍑 2^7-1
 ===========================**/


// &+ : 오버플로우 더하기 연산자

var a = UInt8.max  // 현재 변수 a에 UInt8타입의 최대값이 들어있음(255)
a = a &+ 1         // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(0)으로 이동

//a = 0b11111111 &+ 0b00000001




// &- : 오버플로우 빼기 연산자

var b = UInt8.min  // 현재 변수 b에 UInt8타입의 최소값이 들어있음(0)
b = b &- 1         // 오버플로우 빼기 연산자로 1을 빼기 ==========> 최대값(255)으로 이동

//b = 0b00000000 &- 0b00000001




/*:
---
* 부호가 있는 경우(Signed)의 오버플로우
---
*/
/**=========================
 - Int8타입의 범위: -128 ~ 127
 ===========================**/


// &+ : 오버플로우 더하기 연산자

var a1 = Int8.max   // 현재 변수 a1에 Int8타입의 최대값이 들어있음(127)
a1 = a1 &+ 1        // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(-128)으로 이동

//a1 = 0b01111111 &+ 0b00000001


// &- : 오버플로우 빼기 연산자

var b1 = Int8.min   // 현재 변수 b1에 Int8타입의 최소값이 들어있음(-128)
b1 = b1 &- 1        // 오버플로우 빼기 연산자로 1을 빼기 ==========> 최대값(127)으로 이동


//b1 = -0b10000000 &- 0b00000001



// &* : 오버플로우 곱하기 연산자

var c1 = Int8.max   // 현재 변수 c에 Int8타입의 최대값이 들어있음(127)
c1 = c1 &* 2        // 오버플로우 곱하기 연산자로 2 곱하기 ==========> 비트 한칸씩 이동


//c = 0b01111111 &* 2








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
