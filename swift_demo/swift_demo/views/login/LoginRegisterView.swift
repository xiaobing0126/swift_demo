//
//  ContentView.swift
//  iOS_demo
//
//  Created by 小饼子 on 2025/12/20.
//

import SwiftUI

// MARK: - 表单数据结构体
struct LoginFormData {
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var nickname: String = ""
    
    // 验证登录表单
    var isLoginValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    // 验证注册表单
    var isRegisterValid: Bool {
        !username.isEmpty && !password.isEmpty && !nickname.isEmpty && password == confirmPassword
    }
    
    // 密码是否匹配
    var isPasswordMatch: Bool {
        password == confirmPassword
    }
}

struct LoginRegisterView: View {
    
    private enum AuthMode: String, CaseIterable, Identifiable {
        case login = "登录"
        case register = "注册"

        var id: String { rawValue }
    }

    @State private var mode: AuthMode = .login
    @State private var formData = LoginFormData()  // 使用结构体管理表单数据
    @State private var isShowingNamePwdAlert = false
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = "提示"
    @State private var isLoggedIn = false  // 控制登录成功后跳转
    @State private var showSwiftLearning = false  // 控制跳转到 Swift 学习页面
    
    // 处理按钮点击事件
    private func handleButtonTap() {
        
        var optionalString: String? = "Hello"
        print(optionalString == nil)

        var optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")

        default:
            print("当前模式: \(mode.rawValue)")
        }
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (_, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        print(largest)
        // 输出 "25"
        
        // 获取当前时间
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: currentDate)
        
        // 基础验证 - 使用结构体的验证属性
        guard formData.isLoginValid else {
            print("❌ 用户名或密码不能为空")
            isShowingNamePwdAlert = true
            return
        }
        
        if mode == .login {
            print("=== 登录操作 ===")
            print("时间: \(dateString)")
            print("用户名: \(formData.username)")
            
            // 调用登录 API - 使用结构体属性
            UserAPI.shared.login(username: formData.username, password: formData.password) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let loginData):
                        print("✅ 登录成功!")
                        print("Token: \(loginData.token)")
                        
                        // 登录成功，跳转到主页
                        isLoggedIn = true
                        
                    case .failure(let error):
                        print("❌ 登录失败: \(error.localizedDescription)")
                        
                        alertTitle = "登录失败"
                        alertMessage = error.localizedDescription
                        isShowingAlert = true
                    }
                }
            }
            
        } else {
            // 注册模式
            print("=== 注册操作 ===")
            print("时间: \(dateString)")
            print("昵称: \(formData.nickname)")
            print("用户名: \(formData.username)")
            print("密码匹配状态: \(formData.isPasswordMatch ? "✅ 匹配" : "❌ 不匹配")")
            
            // 使用结构体的验证属性
            guard formData.isRegisterValid else {
                if !formData.isPasswordMatch {
                    print("❌ 两次输入的密码不一致")
                    alertTitle = "注册失败"
                    alertMessage = "两次输入的密码不一致"
                } else if formData.nickname.isEmpty {
                    print("❌ 昵称不能为空")
                    alertTitle = "注册失败"
                    alertMessage = "昵称不能为空"
                }
                isShowingAlert = true
                return
            }
            
            // 调用注册 API - 使用结构体属性
            UserAPI.shared.register(
                username: formData.username,
                password: formData.password,
                nickname: formData.nickname
            ) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let userData):
                        print("✅ 注册成功!")
                        print("用户 ID: \(userData.userId)")
                        print("昵称: \(userData.nickname)")
                        print("用户名: \(userData.username)")
                        print("Token: \(userData.token)")
                        
                        alertTitle = "注册成功"
                        alertMessage = "注册成功，请登录"
                        isShowingAlert = true
                        
                        // 注册成功后切换到登录模式
                        mode = .login
                        
                    case .failure(let error):
                        print("❌ 注册失败: \(error.localizedDescription)")
                        alertTitle = "注册失败"
                        alertMessage = error.localizedDescription
                        isShowingAlert = true
                    }
                }
            }
        }
        
        print("========================\n")
    }

    // 跳转到 Swift 学习页面
    private func handleSwift() {
        print("跳转到 Swift 学习页面")
        showSwiftLearning = true
    }
    
    @State private var test = "Test"  // 普通私有变量
    var body: some View {
        VStack(spacing: 20) {
            
            VStack {
                Button {
                    handleSwift()
                } label: {
                    Text("swift学习")
                }
                Text(test)
            }
            
            VStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 54))
                    .foregroundStyle(.tint)
                Text("欢迎")
                    .font(.title2.bold())
                Text(mode == .login ? "请登录你的账号" : "创建一个新账号")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Picker("模式", selection: $mode) {
                ForEach(AuthMode.allCases) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            .pickerStyle(.segmented)

            VStack(spacing: 12) {
                if mode == .register {
                    TextField("昵称", text: $formData.nickname)
                        .textInputAutocapitalization(.words)
                        .textContentType(.nickname)
                        .textFieldStyle(.roundedBorder)
                }

                TextField("用户名", text: $formData.username)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
                    .textFieldStyle(.roundedBorder)

                SecureField("密码", text: $formData.password)
                    .textContentType(mode == .login ? .password : .newPassword)
                    .textFieldStyle(.roundedBorder)

                if mode == .register {
                    SecureField("确认密码", text: $formData.confirmPassword)
                        .textContentType(.newPassword)
                        .textFieldStyle(.roundedBorder)
                }
            }

            Button {
                handleButtonTap()
            } label: {
                Text(mode == .login ? "登录" : "注册")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            if mode == .login {
                Button("忘记密码？") {
                    isShowingAlert = true
                }
                .font(.footnote)
            } else {
                Text("注册即表示同意用户协议与隐私政策")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .navigationDestination(isPresented: $isLoggedIn) {
            SettingView()
        }
        .navigationDestination(isPresented: $showSwiftLearning) {
            ClassAndStructView()
        }
        .alert("提示", isPresented: $isShowingNamePwdAlert) {
            Button("确定", role: .cancel) {}
        } message: {
            Text("用户名或密码不能为空")
        }
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("确定", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}




#Preview {
    NavigationStack {
        LoginRegisterView()
    }
}
