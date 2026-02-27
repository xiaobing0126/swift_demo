//
//  NetworkManager.swift
//  iOS_demo
//
//  网络请求封装类 - 基于 Alamofire
//

import Foundation
import Alamofire

// MARK: - 网络请求响应模型
struct APIResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
}

// MARK: - 网络错误类型
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int, String)
    case networkFailure(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "无效的URL"
        case .noData:
            return "没有数据返回"
        case .decodingError:
            return "数据解析失败"
        case .serverError(let code, let message):
            return "服务器错误(\(code)): \(message)"
        case .networkFailure(let message):
            return "网络请求失败: \(message)"
        }
    }
}

// MARK: - 请求方法枚举
enum HTTPMethodType {
    case get
    case post
    case put
    case delete
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        }
    }
}

// MARK: - 网络请求管理类
class NetworkManager {
    
    // 单例模式
    static let shared = NetworkManager()
    
    // 基础URL - 请根据实际情况修改
//    private let baseURL = "https://api.example.com"
    private let baseURL = "http://127.0.0.1:3000"
    
    // 默认请求头
    private var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "Accept", value: "application/json")
        // 如果有 token，可以在这里添加
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        return headers
    }
    
    // 请求超时时间
    private let timeoutInterval: TimeInterval = 30
    
    private init() {}
    
    // MARK: - 通用请求方法
    /// 通用网络请求
    /// - Parameters:
    ///   - endpoint: API 端点路径
    ///   - method: 请求方法
    ///   - parameters: 请求参数
    ///   - headers: 自定义请求头（可选）
    ///   - completion: 完成回调
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethodType = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let urlString = baseURL + endpoint
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let requestHeaders = headers ?? defaultHeaders
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        // 打印请求信息用于调试
        print("📡 发送请求: \(method.alamofireMethod) \(urlString)")
        if let params = parameters {
            print("📦 请求参数: \(params)")
        }
        
        AF.request(
            url,
            method: method.alamofireMethod,
            parameters: parameters,
            encoding: encoding,
            headers: requestHeaders
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            // 打印响应信息用于调试
            print("📥 响应状态: \(response.response?.statusCode ?? -1)")
            if let data = response.data {
                print("📥 响应数据: \(String(data: data, encoding: .utf8) ?? "无法解析")")
            }
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("❌ 解析错误: \(error.localizedDescription)")
                if let statusCode = response.response?.statusCode {
                    completion(.failure(.serverError(statusCode, error.localizedDescription)))
                } else {
                    completion(.failure(.networkFailure(error.localizedDescription)))
                }
            }
        }
    }
    
    // MARK: - GET 请求
    func get<T: Codable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        request(endpoint: endpoint, method: .get, parameters: parameters, completion: completion)
    }
    
    // MARK: - POST 请求
    func post<T: Codable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        request(endpoint: endpoint, method: .post, parameters: parameters, completion: completion)
    }
    
    // MARK: - PUT 请求
    func put<T: Codable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        request(endpoint: endpoint, method: .put, parameters: parameters, completion: completion)
    }
    
    // MARK: - DELETE 请求
    func delete<T: Codable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        request(endpoint: endpoint, method: .delete, parameters: parameters, completion: completion)
    }
    
    // MARK: - 上传图片
    func uploadImage(
        endpoint: String,
        imageData: Data,
        fileName: String = "image.jpg",
        mimeType: String = "image/jpeg",
        parameters: [String: String]? = nil,
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        let urlString = baseURL + endpoint
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: mimeType)
                
                // 添加额外参数
                if let params = parameters {
                    for (key, value) in params {
                        if let data = value.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
            },
            to: urlString,
            headers: defaultHeaders
        )
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String: Any] {
                    completion(.success(dict))
                } else {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(.networkFailure(error.localizedDescription)))
            }
        }
    }
    
    // MARK: - Async/Await 支持 (iOS 13+)
    @available(iOS 13.0, *)
    func requestAsync<T: Codable>(
        endpoint: String,
        method: HTTPMethodType = .get,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            request(endpoint: endpoint, method: method, parameters: parameters) { (result: Result<T, NetworkError>) in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - 使用示例
/*
 
 // 1. GET 请求示例
 NetworkManager.shared.get(endpoint: "/users") { (result: Result<[User], NetworkError>) in
     switch result {
     case .success(let users):
         print("获取用户列表成功: \(users)")
     case .failure(let error):
         print("请求失败: \(error.localizedDescription)")
     }
 }
 
 // 2. POST 请求示例
 let params = ["email": "test@example.com", "password": "123456"]
 NetworkManager.shared.post(endpoint: "/login", parameters: params) { (result: Result<LoginResponse, NetworkError>) in
     switch result {
     case .success(let response):
         print("登录成功: \(response)")
     case .failure(let error):
         print("登录失败: \(error.localizedDescription)")
     }
 }
 
 // 3. Async/Await 方式 (iOS 13+)
 Task {
     do {
         let users: [User] = try await NetworkManager.shared.requestAsync(endpoint: "/users")
         print("获取用户列表成功: \(users)")
     } catch {
         print("请求失败: \(error)")
     }
 }
 
*/
