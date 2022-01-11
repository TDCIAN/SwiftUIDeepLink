//
//  ProfileView.swift
//  SwiftUIDeepLink
//
//  Created by JeongminKim on 2022/01/07.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Rectangle().foregroundColor(Color.init(UIColor.systemPurple))
            .frame(width: 350, height: 350)
            .cornerRadius(15)
            .overlay(
                Image(systemName: "person")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 300, height: 300)
            )
        
    }
}

