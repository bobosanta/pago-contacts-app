//
//  UsersService.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import Foundation

class UsersService: ObservableObject {
    
    @Published var users: [User] = []
    
    func getUsers() {
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                let activeUsers = decodedUsers.filter { $0.status == "active" }
                DispatchQueue.main.async {
                    self.users = activeUsers
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
}
