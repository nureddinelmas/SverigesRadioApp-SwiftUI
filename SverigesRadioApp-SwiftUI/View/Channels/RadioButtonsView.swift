//
//  RadioButtonsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-08.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI


struct RadioButtonsView: View {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        @State var isAnimated = false
        @State var isPlaying = true
        @State var player:AVPlayer?
        @State var sliderValue: Float = 0.0
        @ObservedObject var toUIColor = HexStringToUIColor()
//        @ObservedObject var apiChannelModel : ChannelApiModel
        @State var indexItem : Int
        let channe : [Channels]
    
        var channelItem : Channels { return channe[indexItem] }
    
        var arrayCount : Int { return channe.count-1 }
//        var audioPlayer = AVAudioPlayer()

        var body: some View {

            ZStack {
             
                let renk = toUIColor.hexStringToUIColor(hex: channelItem.color ?? "")
                Color(renk).ignoresSafeArea()
                VStack{
                    ZStack{
                        Circle().foregroundColor(.gray).shadow(radius: 20).opacity(0.4).frame(width: width * 0.92 , height: height * 0.43)
                        Circle().foregroundColor(.white).shadow(radius: 10).opacity(0.5).frame(width: width * 0.88 , height: height * 0.38)
                        WebImage(url: URL(string: channelItem.imagetemplate ?? "")).resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                                .frame(width: width * 0.7 , height: height * 0.3)
                    }.shadow(color: .black, radius: 10)
                    Spacer()
                    
                    ZStack{
                        VStack{
                            Text(channelItem.name!).frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.white).font(.system(size: 23)).padding()
                            Text(channelItem.channeltype!).foregroundColor(.white).font(.headline)
                        }

                        
                        AnimatedImage(url: URL(string: "https://miro.medium.com/max/724/1*yZdxL9Hh878Ivnn-bjP9Tw.gif"), isAnimating : $isAnimated).resizable().scaledToFill().opacity(0.2).onAppear {
                            isAnimated = false
                            print(isAnimated)
                        }
 
                    }.frame(width: width * 0.4, height: height * 0.1).scaledToFill().padding()
                    
                    Spacer()
                    HStack{
                        Image(systemName: "speaker").foregroundColor(.white).font(.system(size: 30))
                        Slider(value: $sliderValue, in: 0...1, onEditingChanged: { _ in
                            player?.volume = sliderValue
                        })
                           
                    
                        Image(systemName: "speaker.wave.2").foregroundColor(.white).font(.system(size: 30))
                    }.padding()
                   
                    Spacer()
                    HStack{
                        Button(action: {
                            if indexItem != 0 {
                                indexItem = indexItem - 1
                                isPlaying.toggle()
                                playing()
                            }
                            
                        }) {
                            ZStack{
                                Circle().frame(width: width * 0.2, height: height * 0.06, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                                Image(systemName: "backward.circle").font(.system(size: 50)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 20)
                        }
                        
                        Button(action: {
                            playing()
                            isAnimated.toggle()
                            player?.volume = sliderValue
                        }) {
                            ZStack{
                                Circle().frame(width: width * 0.4, height: height * 0.1, alignment: .center).foregroundColor(Color.white.opacity(0.2))
                                Image(systemName: isPlaying ? "play.circle" : "pause.circle").font(.system(size: 90)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 10)
                        }
                       
                        Button(action: {
                            if indexItem != arrayCount {
                                indexItem = indexItem + 1
                                isPlaying.toggle()
                                playing()
                            }
                            
                        }) {
                            ZStack{
                                Circle().frame(width: width * 0.2, height: height * 0.06, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                                Image(systemName: "forward.circle").font(.system(size: 50)).foregroundColor(.white)
                            }.shadow(color: .black, radius: 20)
                        }
                        }
                    Spacer()
                }

            }
            
        }
        

        private func playing(){
            let playerItem:AVPlayerItem = AVPlayerItem(url: URL(string: channelItem.liveaudio.url)!)
            player = AVPlayer(playerItem: playerItem)

            if isPlaying{
                player?.play()
                isPlaying.toggle()
               
            } else {
                player?.pause()
                isPlaying.toggle()
            }

        }
    
    
    }
