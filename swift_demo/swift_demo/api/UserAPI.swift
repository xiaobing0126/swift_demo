//
//  UserAPI.swift
//  iOS_demo
//
//  用户相关的 API 请求

import Foundation

// MARK: - 请求模型

struct LoginRequest: Codable {
    let username: String
    let password: String
}

// MARK: - 响应模型

struct LoginResponse: Codable {
    let code: Int
    let message: String
    let data: LoginData?

    // 登录返回的数据 - 只包含 token
    struct LoginData: Codable {
        let token: String
        // 如果服务器将来返回更多字段，可以在这里添加（设为可选）
        let userId: String?
        let username: String?
        let nickname: String?

        enum CodingKeys: String, CodingKey {
            case token
            case userId = "user_id"
            case username
            case nickname
        }
    }
}

struct RegisterRequest: Codable {
    let username: String
    let password: String
    let nickname: String
}

struct RegisterResponse: Codable {
    let code: Int
    let message: String
    let data: UserData?

    struct UserData: Codable {
        let userId: String
        let username: String
        let nickname: String
        let token: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case username
            case nickname
            case token
        }
    }
}

// MARK: - UserAPI 类

class UserAPI {
    static let shared = UserAPI()

    private init() {}

    // MARK: - 登录请求

    /// 用户登录
    /// - Parameters:
    ///   - username: 用户名
    ///   - password: 密码
    ///   - completion: 完成回调
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse.LoginData, NetworkError>) -> Void
    ) {
        // 创建请求体
        let request = LoginRequest(username: username, password: password)

        // 转换为字典用于请求
        guard let requestDict = try? JSONEncoder().encode(request),
              let dict = try? JSONSerialization.jsonObject(with: requestDict) as? [String: Any]
        else {
            print("❌ 请求体编码失败")
            completion(.failure(.decodingError))
            return
        }

        print("🔐 开始登录请求...")
        print("📝 用户名: \(username)")

        // 使用 NetworkManager 发送 POST 请求
        NetworkManager.shared.post(
            endpoint: "/api/user/login",
            parameters: dict
        ) { (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case let .success(response):
                print("✅ 服务器响应成功")
                print("📊 响应代码: \(response.code)")
                print("📝 响应消息: \(response.message)")

                if let loginData = response.data {
                    // 保存 token 到本地
                    UserDefaults.standard.set(loginData.token, forKey: "userToken")
                    print("✅ Token 已保存: \(loginData.token)")
                    completion(.success(loginData))
                } else {
                    print("❌ 响应中没有登录数据")
                    completion(.failure(.noData))
                }
            case let .failure(error):
                print("❌ 登录请求失败: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    // MARK: - 注册请求    // MARK: - 注册请求

    /// 用户注册
    /// - Parameters:
    ///   - username: 用户名
    ///   - password: 密码
    ///   - nickname: 昵称
    ///   - completion: 完成回调
    func register(
        username: String,
        password: String,
        nickname: String,
        completion: @escaping (Result<RegisterResponse.UserData, NetworkError>) -> Void
    ) {
        // 创建请求体
        let request = RegisterRequest(username: username, password: password, nickname: nickname)

        // 转换为字典用于请求
        guard let requestDict = try? JSONEncoder().encode(request),
              let dict = try? JSONSerialization.jsonObject(with: requestDict) as? [String: Any]
        else {
            completion(.failure(.decodingError))
            return
        }

        // 使用 NetworkManager 发送 POST 请求
        NetworkManager.shared.post(
            endpoint: "/api/user/register",
            parameters: dict
        ) { (result: Result<RegisterResponse, NetworkError>) in
            switch result {
            case let .success(response):
                if let userData = response.data {
                    // 保存 token 到本地
                    UserDefaults.standard.set(userData.token, forKey: "userToken")
                    completion(.success(userData))
                } else {
                    completion(.failure(.noData))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - 获取用户信息

    /// 获取当前登录用户信息
    /// - Parameter completion: 完成回调
    func getUserInfo(completion: @escaping (Result<LoginResponse.LoginData, NetworkError>) -> Void) {
        NetworkManager.shared.get(endpoint: "/api/user/info") { (result: Result<LoginResponse, NetworkError>) in
            switch result {
            case let .success(response):
                if let loginData = response.data {
                    completion(.success(loginData))
                } else {
                    completion(.failure(.noData))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - 退出登录

    /// 用户退出登录
    /// - Parameter completion: 完成回调
    func logout(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        NetworkManager.shared.post(endpoint: "/user/logout") { (result: Result<[String: String], NetworkError>) in
            switch result {
            case .success:
                // 清除本地保存的 token
                UserDefaults.standard.removeObject(forKey: "userToken")
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
