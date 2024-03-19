//
//  UserProfileImageView.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 19.03.2024.
//

import SwiftUI

struct UserProfileImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://picsum.photos/200/200")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 46, height: 46)
                    .clipShape(.circle)
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    UserProfileImageView()
}
