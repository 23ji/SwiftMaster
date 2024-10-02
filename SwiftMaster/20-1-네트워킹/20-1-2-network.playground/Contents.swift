import UIKit

/*:
 ## 네트워크 통신(서버와의 통신)의 기초
 * 요청(Request) ➡︎ 서버데이터(JSON) ➡︎ 분석(Parse) ➡︎ 변환 (우리가 쓰려는 Struct/Class)
 ---
 */
// 서버에서 주는 데이터 ===========================================================
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


// 🍑 서버에서 주는 데이터는 변형할 수 없고 변형하기 위해선 아래처럼 서버에선 온 데이터를 변형해서 사용해야함
// 내가 만들고 싶은 데이터 (우리가 쓰려는 Struct / Class) =======================
struct Movie {
    static var movieId: Int = 0   // 아이디가 하나씩 부여되도록 만듦
    let movieName: String
    let rank: Int
    let openDate: String
    let todayAudience: Int
    let totalAudience: Int
    
    init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String) {
        self.movieName = movieNm
        self.rank = Int(rank)!
        self.openDate = openDate
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        Movie.movieId += 1
    }
    
}



// 서버와 통신 ===========================================================
struct MovieDataManager {
    
    let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    
    let myKey = "7a526456eb8e084eb294715e006df16f"
    // 🍑 데이터 가져오는 함수 이름 보통 fetch~ 이런식으로 많이 지정
    func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(movieURL)&key=\(myKey)&targetDt=\(date)"
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    // 🍑 리턴형으로 전달안하고 콜백 함수로 결과,,, 이유는 다음 단원에서 설명!
    func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        // 1. URL 구조체 만들기
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
        let session = URLSession(configuration: .default)
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            // 🍑  클로저에서 객체의 속성이나 메서드에 접근하려면 반드시 셀프를 붙여줘야한다!
            // 데이터 분석하기
            if let movies = self.parseJSON(safeData) {
                //print("parse")
                completion(movies)
            } else {
                completion(nil)
            }
        }
        
        // 4.Start the task
        task.resume()   // 일시정지된 상태로 작업이 시작하기 때문
    }
    
    
    func parseJSON(_ movieData: Data) -> [Movie]? {
        // 함수실행 확인 코드
        print(#function)
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList
            
            // 반복문으로 movie배열 생성 ⭐️
//            var myMovielists = [Movie]()
//
//            for movie in dailyLists {
//
//                let name = movie.movieNm
//                let rank = movie.rank
//                let openDate = movie.openDt
//                let todayAudi = movie.audiCnt
//                let accAudi = movie.audiAcc
//
//                let myMovie = Movie(movieNm: name, rank: rank, openDate: openDate, audiCnt: todayAudi, accAudi: accAudi)
//
//                myMovielists.append(myMovie)
//            }
            
            // 🍑 위에 처럼 해도되지만 고 차함수 이용해서 간편하게!
            // 고차함수를 이용해 movie배열 생성하는 경우 ⭐️
            
            let myMovielists = dailyLists.map {
                Movie(movieNm: $0.movieNm, rank: $0.rank, openDate: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc)
            }
            
            return myMovielists
            
        } catch {
            //print(error.localizedDescription)
            
            // (파싱 실패 에러)
            print("파싱 실패")
            
            return nil
        }
        
    }
    
}


// 뷰컨트롤러에서 일어나는 일 ===========================================================
// 빈배열
var downloadedMovies = [Movie]()

// 데이터를 다운로드 및 분석/변환하는 구조체
let movieManager = MovieDataManager()


// 실제 다운로드 코드
movieManager.fetchMovie(date: "20210201") { (movies) in
    
    if let movies = movies {
        
        // 배열 받아서 빈배열에 넣기
        downloadedMovies = movies
        dump(downloadedMovies)
        
        print("전체 영화 갯수 확인: \(Movie.movieId)")
    } else {
        print("영화데이터가 없습니다. 또는 다운로드에 실패했습니다.")
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
