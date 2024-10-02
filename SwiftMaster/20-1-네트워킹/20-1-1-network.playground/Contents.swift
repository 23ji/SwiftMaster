import UIKit


/*:
 # Part20 - 1 - 네트워킹(Networking)
 */
/*:
 ## 네트워크 통신(서버와의 통신)의 기초
 * 참고 URL
 ---
 */
// 영화 진흥위원회 오픈 API
// https://www.kobis.or.kr/kobisopenapi/homepg/main/main.do


// 요청주소
// http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json


// 키: 각자의 것으로 발급


// 요청 예시
// http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=KEYVALUE&targetDt=20210201

// 🍑 &으로 연결된 것들은 순서 바꿔서 입력해도 됨
// 🍑 KEYVALUE에는 자신이 해당 API에 발급받은 키 값을 쓰면 됨

// JSON데이터를 스위프트 코드로 변환
// https://app.quicktype.io/


//:> session(세션) 영단어 뜻: 기간 / 시간
// 세션 ==> 연결 상태 유지 ⭐️
// 일정 시간동안 같은 브라우저(사용자)로부터 들어오는 연결 상태를 일정하게 유지시키는 기술(상태)

/*:
 ---
 * iOS에서의 네트워킹의 기본
 ---
 */
// 0. URL주소 - 문자열로
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=⭐️본인들각자의키값입력⭐️&targetDt=20210201"


// 1. URL 구조체 만들기
let url = URL(string: movieURL)!


// 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
let session = URLSession.shared


// 3. 세션에 (일시정지 상태로)작업 부여
let task = session.dataTask(with: url) { (data, response, error) in
    if error != nil {
        print(error!)
        return
    }
    
    guard let safeData = data else {
        return
    }
    
    // 데이터를 그냥 한번 출력해보기
    //print(String(decoding: safeData, as: UTF8.self))
    
    dump(parseJSON1(safeData)!)
    
    
}

// 4.작업시작
task.resume()   // 일시정지된 상태로 작업이 시작하기 때문


// ⭐️ 비동기적으로 동작함




// 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ======================================
// 🍑 분석을 위한 함수 만들기
// 현재의 형태
func parseJSON1(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        // 스위프트5
        // 자동으로 원하는 클래스/구조체 형태로 분석
        // JSONDecoder
        let decoder = JSONDecoder()
        // 🍑 .self 로 써야하는 것 유의 ! 인스턴스가 아니라 붕어빵 틀 자체의 데이터라는 뜻에서.
        // 🍑 에러를 발생 할 수 있기 때문에 try do catch로 감싸야함
        // 🍑 from: movieData라는 데이터를 가지고 MovieData.self의 형태로 디코딩 하는 것.
        let decodedData = try decoder.decode(MovieData.self, from: movieData)
        // 🍑 리턴값은 옵셔널 배열
        return decodedData.boxOfficeResult.dailyBoxOfficeList
        
    } catch {
        
        return nil
    }
    
}




// 예전의 형태
func parseJSON2(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        
        var movieLists = [DailyBoxOfficeList]()
        
        // 스위프트4 버전까지
        // 딕셔너리 형태로 분석
        // JSONSerialization
        if let json = try JSONSerialization.jsonObject(with: movieData) as? [String: Any] {
            if let boxOfficeResult = json["boxOfficeResult"] as? [String: Any] {
                if let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"] as? [[String: Any]] {
                    
                    for item in dailyBoxOfficeList {
                        let rank = item["rank"] as! String
                        let movieNm = item["movieNm"] as! String
                        let audiCnt = item["audiCnt"] as! String
                        let audiAcc = item["audiAcc"] as! String
                        let openDt = item["openDt"] as! String
                        
                        // 하나씩 인스턴스 만들어서 배열에 append
                        let movie = DailyBoxOfficeList(rank: rank, movieNm: movieNm, audiCnt: audiCnt, audiAcc: audiAcc, openDt: openDt)

                        
                        movieLists.append(movie)
                    }

                    return movieLists

                }
            }
        }

        return nil
        
    } catch {
        
        return nil
    }
    
}




// 서버에서 주는 데이터의 형태
// 🍑 아래와 같은 사이트 이용하여
// JSON데이터를 스위프트 코드로 변환
// https://app.quicktype.io/
//====================================================

// 🍑 Decodable + Encodable = Codable / Codable이란 프로토콜을 채택을 해줘야 JSONDecoder()가 코드 분석 가능
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
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
