import Foundation

struct JokesAPI {
    static var url = URL(string: "https://api.icndb.com/jokes/random")!
    var sampleData: Data {
        Data(
            """
            {
                "type": "success",
                    "value": {
                    "id": 459,
                    "joke": "Chuck Norris can solve the Towers of Hanoi in one move.",
                    "categories": []
                }
            }
            """.utf8
        )
    }
}

class JokesAPIProvider {
    let session: URLSession
    
    init(session: URLSession){
        self.session = session
    }
    
    func fetchRandomJoke(completion: @escaping(Result<Joke, APIError>) -> Void) {}
}
