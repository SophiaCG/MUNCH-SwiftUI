//
//  LogInSignUpVM.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/24/21.
//

import FirebaseAuth
import Combine

//MARK: - User inputs their email and password to either Log In or Sign Up
// Firebase code from: https://www.youtube.com/watch?v=vPCEIPL0U_k&t=15s
enum EmailStatus {
    case empty
    case invalid
    case valid
}

enum PasswordStatus {
    case empty
    case notStrong
    case valid
}

class LogInSignUpVM: ObservableObject {

    @Published var loggedIn = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isValid = false
    @Published var errorMessage = ""
    @Published var errorMessage2 = ""

    private var cancellables = Set<AnyCancellable>()

    var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }

    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.loggedIn = true
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.loggedIn = true
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        self.loggedIn = false
    }

//MARK: - Combine functions for email and password text fields
    private var isEmailEmpty: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }

    private var isEmailValid: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { $0.contains("@") }
            .eraseToAnyPublisher()
    }

    private var isFormValid: AnyPublisher<EmailStatus, Never> {
        Publishers.CombineLatest(isEmailEmpty, isEmailValid)
            .map {
                if $0 { return EmailStatus.empty }
                if !$1 { return EmailStatus.invalid }
                return EmailStatus.valid
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordEmpty: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }

    private var isPasswordStrong: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 6 }
            .eraseToAnyPublisher()
    }

    private var isPasswordValid: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest(isPasswordStrong, isPasswordEmpty)
            .map {
                if !$0 { return PasswordStatus.notStrong }
                if $1 { return PasswordStatus.empty }
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }

    init() {
        isFormValid
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { EmailStatus in
                switch EmailStatus {
                case .empty:
                    return "Email can not be empty"
                case .invalid:
                    return "Please enter a valid email"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)

        isPasswordValid
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { PasswordStatus in
                switch PasswordStatus {
                case .empty:
                    return "Password can not be empty"
                case .notStrong:
                    return "Password must be at least 6 characters long"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.errorMessage2, on: self)
            .store(in: &cancellables)

    }

}
