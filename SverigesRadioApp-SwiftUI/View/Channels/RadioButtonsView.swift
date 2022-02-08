//
//  RadioButtonsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-08.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI


@available(iOS 13.0, *)
struct RadioButtonsView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
        @State var isPlaying = false
        @State var player:AVPlayer?
        @State var sliderValue: Float = 0
        @ObservedObject var toUIColor = HexStringToUIColor()
        @State var isAnimated = true
        var playerItem:AVPlayerItem?
        var audioPlayer = AVAudioPlayer()
    
        var body: some View {

            ZStack {
             
//                let renk = toUIColor.hexStringToUIColor(hex: myChannel.color ?? "")
                Color(.black).ignoresSafeArea()
                VStack{
                    ZStack{
                        Circle().foregroundColor(.gray).shadow(radius: 20).opacity(0.4).frame(width: width * 0.92 , height: height * 0.43)
                        Circle().foregroundColor(.white).shadow(radius: 10).opacity(0.5).frame(width: width * 0.88 , height: height * 0.38)
                        Image("resim").resizable().aspectRatio(contentMode: .fill).foregroundColor(.blue).clipShape(Circle())
                                .frame(width: width * 0.8 , height: height * 0.3)
                    }.shadow(color: .black, radius: 10)
                    Spacer()
                    
                    ZStack{
                        VStack{
                            Text("Program Name").foregroundColor(.white).font(.largeTitle).padding()
                            Text("Details").foregroundColor(.white).font(.headline)
                        }

                        
                        WebImage(url: URL(string: "https://c.tenor.com/36PHqsAC5XoAAAAC/do-i-wanna-know-arctic-monkeys.gif"), isAnimating : $isAnimated).resizable().scaledToFill().frame(width: width, height: 50).opacity(0.2)
 
                    }
                    
                    Spacer()
                    HStack{
                        Image(systemName: "speaker").foregroundColor(.white).font(.system(size: 30))
                        Slider(value: $sliderValue, in: 0...100)
                        Image(systemName: "speaker.wave.2").foregroundColor(.white).font(.system(size: 30))
                    }.padding()
                   
                    Spacer()
                    HStack{
                        Button(action: {}) {
                            ZStack{
                                Circle().frame(width: width * 0.2, height: height * 0.06, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                                Image(systemName: "backward.circle").font(.system(size: 50)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 20)
                        }
                        
                        Button(action: {}) {
                            ZStack{
                                Circle().frame(width: width * 0.4, height: height * 0.1, alignment: .center).foregroundColor(Color.white.opacity(0.2))
                                Image(systemName: isPlaying ? "play.circle" : "pause.circle").font(.system(size: 90)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 10)
                            .onTapGesture {
    //                            playing()
            //                    sliderValue = player!.volume
                            }
                        }
                       
                        Button(action: {}) {
                            ZStack{
                                Circle().frame(width: width * 0.2, height: height * 0.06, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                                Image(systemName: "forward.circle").font(.system(size: 50)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 20)
                        }
                        }
                       
                    
                    Spacer()
    //                Slider(value: $sliderValue, in: 0...100, step: 1).accentColor(Color.green)
    //                Text("Current Slider Value : \(sliderValue, specifier: "%1f")")
                }
    //            SliderView(sliderProgress: player?.volume)

            }
            
        }
        

//        private func playing(){
//            let playerItem:AVPlayerItem = AVPlayerItem(url: URL(string: myChannel.liveaudio.url)!)
//            player = AVPlayer(playerItem: playerItem)
//
//            if isPlaying{
//                player?.play()
//                isPlaying.toggle()
//            } else {
//                player?.pause()
//                isPlaying.toggle()
//            }
//
//        }
    
    
    }

struct RadioButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonsView()
    }
}
