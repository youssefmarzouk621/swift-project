//
//  AuthentificationPresenter.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//
import Foundation

class AuthentificationPresenter:ObservableObject{
    private let interactor:AuthentificationInteractorProtocol
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var isLoading = false
    @Published var showHomeView = false
    init(interactor: AuthentificationInteractorProtocol) {
        self.interactor = interactor
    }
    func authentification(email: String, password: String) {
        /*if let validationError = ValidationUtils.validatePasswordInputs(password: password) {
            self.alertMessage = validationError
            self.showAlert = true
            return
        }*/
        self.isLoading = true
        interactor.authenticate(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    print(response)
                    self.showHomeView = true
                case .failure(let error):
                    print(error)
                    self.alertMessage = "Erreur de connexion: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
}
