
import Moya


/**
 id=6222
 is_night=0
 statistics_uv=0
 type_id=1
 */

let constParame =  [
    "app_id": "com.jzyd.Better",
    "app_installtime": "1476251286",
    "app_versions": "1.5.1",
    "channel_name": "appStore",
    "client_id": "bt_app_ios",
    "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
    "device_token": "711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a",
    "oauth_token": "1cfdf7dc28066c076c23269874460b58",
    "os_versions": "10.0.2",
    "screensize": "750",
    "track_device_info": "iPhone7%2C2",
    "track_deviceid": "18B31DD0-2B1E-49A9-A78A-763C77FD65BD",
    "track_user_id": "2670024",
    "v": "14",
    "id": "6222",
    "is_night": "0",
    "statistics_uv": "0",
    "type_id": "1"
]


enum BanTService {
    
    case newInfo
    case createUser(firstName: String, lastName: String)
}


extension BanTService: TargetType {
    var baseURL: URL { return URL(string: "http://open3.bantangapp.com")! }
    var path: String {
        switch self {
        case .newInfo:
            return "/topic/newInfo"
            
        case .createUser(_, _):
            return "/users"
        }
    }
    var method: Moya.Method {
        switch self {
        case .newInfo:
            return .get
        case .createUser:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .newInfo :
            return constParame
        case .createUser(let firstName, let lastName):
            return ["first_name": firstName, "last_name": lastName]
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .newInfo , .createUser:
            return .request
        }
    }
}

// MARK: - Helpers
private extension String {
    
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
