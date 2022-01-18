//
//  SideMenuHeaderView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-18.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                withAnimation(.spring()){
                    isShowing.toggle()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            }

            VStack(alignment: .leading){
                Text("Sveriges Radio")
                    .font(.system(size: 24, weight: .semibold))
                Text("Menu").font(.system(size: 14))
                HStack(spacing: 12){
                    Spacer()
                }
                  Spacer()
            }.padding()
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
