import Foundation

struct Message :Codable{ let success : String }
struct MessageTrue: Codable{
    let success : String
    let response : token
}
struct token : Codable{ let token : String}

struct MessageFalse: Codable{
    let success : String
    let error : errors
}
struct errors : Codable{
    let error_code : Int
    let error_msg : String
}
struct pay{
    var desc : String = ""
    var amount : String = ""
    var currency :String = ""
    var created : String = ""
}

func SignIn(login : String?, password : String?) -> (Bool,String)
{
    var semaphore = DispatchSemaphore (value: 0)
    var success : Bool = false
    var message : String = ""
    let json: [String: Any] = ["login": login!, "password": password!]
    let postData = try? JSONSerialization.data(withJSONObject: json)
    var request = URLRequest(url: URL(string: "http://82.202.204.94/api-test/login")!,timeoutInterval: Double.infinity)
    request.addValue("12345", forHTTPHeaderField: "app-key")
        request.addValue("1", forHTTPHeaderField: "v")
        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        print(String(data: data, encoding: .utf8)!)
        guard let info = try? JSONDecoder().decode(Message.self, from: data) else{
            print("Error Decodable")
            return}
        
           if info.success == "true"{
                guard let infoTrue = try? JSONDecoder().decode(MessageTrue.self, from: data) else{
                    print("Error Decodable True")
                    return}
                success = true
                message = infoTrue.response.token
                semaphore.signal()
            }else{
                guard let infoFalse = try? JSONDecoder().decode(MessageFalse.self, from: data) else{
                    print("Error Decodable False")
                    return}
                success = false
                message = infoFalse.error.error_msg
                semaphore.signal()
            }
        }
        task.resume()
    semaphore.wait()
    print(message)
    return(success,message)
}

func loadPauments(token : String) -> (Bool ,[pay] , String)
{
    var semaphore = DispatchSemaphore (value: 0)
    var success : Bool = false
    var message : String = ""
    var mas : [pay] = []
    var answer : String = ""
    var request = URLRequest(url: URL(string: "http://82.202.204.94/api-test/payments?token=\(token)")!,timeoutInterval: Double.infinity)
    request.addValue("12345", forHTTPHeaderField: "app-key")
        request.addValue("1", forHTTPHeaderField: "v")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        answer = String(data: data, encoding: .utf8)!
        print(answer)
        guard let info = try? JSONDecoder().decode(Message.self, from: data) else{
            print("Error Decodable")
            return}
            
            
            if info.success == "true"{
                success = true
                mas = parser(answer)
                semaphore.signal()
            }else{
                guard let infoFalse = try? JSONDecoder().decode(MessageFalse.self, from: data) else{
                    print("Error Decodable False")
                    return}
                success = false
                message = infoFalse.error.error_msg
                semaphore.signal()
            }
        }
        task.resume()
    semaphore.wait()
    return(success,mas,message)
}

func parser (_ answer : String) -> [pay]
{
    var payMas : [pay] = []
    var payItem = pay()
    var key : String = ""
    var value : String = ""
    var i : Int = 1
    while (answer[i+1] != "]") {
        while (answer[i] != "{"){i = i + 1}
        i = i + 1
        while (answer[i] != "}"){
            while (answer[i] != ":"){
                key.append(answer[i])
                i = i + 1
            }
            i = i + 1
            switch key {
            case "\"desc\"":
                while (answer[i] != ","){
                    value.append(answer[i])
                    i = i + 1
                }
                payItem.desc = notQuotes(value)
                key = ""
                value = ""
                i = i + 1
            case "\"amount\"":
                while (answer[i] != ","){
                    value.append(answer[i])
                    i = i + 1
                }
                payItem.amount = notQuotes(value)
                key = ""
                value = ""
                i = i + 1
            case "\"currency\"":
                while (answer[i] != ","){
                    value.append(answer[i])
                    i = i + 1
                }
                payItem.currency = notQuotes(value)
                key = ""
                value = ""
                i = i + 1
            case "\"created\"":
                while (answer[i] != "}"){
                    value.append(answer[i])
                    i = i + 1
                }
                payItem.created = notQuotes(value)
                key = ""
                value = ""
            default:
                key = ""
                value = ""
                break
            }
        }
        payMas.append(payItem)
        payItem = pay()
    }
    return payMas
}

func notQuotes (_ string : String) -> String {
    var str = string
    if str[0] == "\""{
        str.remove(at: str.startIndex)
    }
    if str[str.count-1] == "\""{
        str.remove(at: str.index(before: str.endIndex))
    }
    return str
}


extension StringProtocol {

    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
}
