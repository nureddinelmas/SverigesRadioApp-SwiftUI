//
//  SliderView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import SwiftUI

struct SliderView: View {
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
//    Slider Properties...
    @State var sliderProgress: CGFloat
    @State var sliderHeigth: CGFloat = 0
    @State var lastDragValue: CGFloat = 0

    
    var body: some View {
        NavigationView{
            VStack{
//                 Slider..
                ZStack(alignment: .bottom){
                    Rectangle()
                        .fill(Color.red).opacity(0.15)
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: sliderHeigth)
                }
                .frame(width: 100, height: maxHeight)
                .cornerRadius(35)
//                Container
                .overlay(
                Text("\(Int(sliderProgress * 100))%")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 18)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.vertical, 30)
                    .offset(y: sliderHeigth < maxHeight - 105 ? -sliderHeigth : -maxHeight + 105)
                ,alignment: .bottom
                )
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
//                     getting drag value...
                    let translation = value.translation
                    sliderHeigth = -translation.height + lastDragValue
                    
//                    Limiting slider heigth value...
                    sliderHeigth = sliderHeigth > maxHeight ? maxHeight : sliderHeigth
                    
                    sliderHeigth = sliderHeigth >= 0 ? sliderHeigth : 0
                    
                    //uppdating Progress
                     let progress = sliderHeigth / maxHeight
                     sliderProgress = progress <= 1.0 ? progress : 1
                }).onEnded({ value in
//                    storing last drag value for restoration...
                    
                    sliderHeigth = sliderHeigth > maxHeight ? maxHeight : sliderHeigth
                    
//                    Negative Heigth....
                    sliderHeigth = sliderHeigth >= 0 ? sliderHeigth : 0
                    lastDragValue = sliderHeigth
                }))

            }
//            .frame(maxWidth: sliderHeigth,maxHeight: sliderHeigth )
            
            .background(Color.blue).ignoresSafeArea()
            .cornerRadius(29)
            .preferredColorScheme(.dark)
//            .navigationTitle("Dashboard")
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(sliderProgress: 0).previewLayout(.sizeThatFits)
    }
}
