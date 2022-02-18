//
//  RadioButtonsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-02-08.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI


struct RadioView: View {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        @State var isAnimated = true
        @State var isPlaying = true
        @State var player:AVPlayer?
        @State var sliderValue: Float = 0.2
        @ObservedObject var toUIColor = HexStringToUIColor()
        @State var indexItem : Int
    
        @ObservedObject var viewModel : ChannelApiModel
    
        var channe = [Channels]()

        var arrayCount : Int { return channe.count-1 }
    

        var body: some View {
            
            ZStack {
                let renk = toUIColor.hexStringToUIColor(hex: channe[indexItem].color ?? "")
                Color(renk).ignoresSafeArea()
                VStack{
                    ZStack{
                        Circle().foregroundColor(.gray).shadow(radius: 20).opacity(0.4).frame(width: width * 0.92 , height: height * 0.43)
                        Circle().foregroundColor(.white).shadow(radius: 10).opacity(0.5).frame(width: width * 0.88 , height: height * 0.38)
                        WebImage(url: URL(string: channe[indexItem].imagetemplate ?? "")).resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
                                .frame(width: width * 0.7 , height: height * 0.3)
                    }.shadow(color: .black, radius: 10)
                    Spacer()

                    ZStack{
                        VStack{
                            Text(channe[indexItem].name ?? "").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.white).font(.system(size: 23))
                            Text(channe[indexItem].tagline ?? "").foregroundColor(.white).font(.headline).frame(width: width * 0.9, height: height * 0.1).lineLimit(4).frame(maxWidth: .infinity, maxHeight: .infinity)
                        }


                        AnimatedImage(url: URL(string: "https://miro.medium.com/max/724/1*yZdxL9Hh878Ivnn-bjP9Tw.gif"), isAnimating : $isAnimated).resizable().scaledToFill().opacity(0.2).onAppear {
                            isAnimated = true
                        }.frame(width: width * 0.9, height: height * 0.2).scaledToFit().padding().clipped()

                    }

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
                        }.onAppear{
                            playing()
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
                    }.padding(.bottom, 10)
                    Spacer()
                }

            }
            .navigationBarItems(trailing:LikeButtonChannelView(chn: channe[indexItem])
            )

        }


        private func playing(){
            let playerItem:AVPlayerItem = AVPlayerItem(url: URL(string: channe[indexItem].liveaudio.url)!)
            player = AVPlayer(playerItem: playerItem)

            if isPlaying {
                player?.play()
                isPlaying.toggle()

            } else {
                player?.pause()
                isPlaying.toggle()
            }

        }
    
    
//
//
//    var kalp : some View {
//        Button(action: {
////                Like button Action
//
//                  print("channe[indexItem] - \(channe[indexItem])")
//            print("indexItem - \(indexItem)")
//
//                           if viewModel.checkChannelIsSaved(channel: channe[indexItem]) {
//                               viewModel.deleteChannelToSavedInFirebase(channel: channe[indexItem])
//                           } else {
//                           viewModel.saveChannelFavorite(channelFavori: channe[indexItem])
//                           }
//
//
//        }) {
//            Image(systemName: viewModel.checkChannelIsSaved(channel: channe[indexItem]) ? "heart.fill" : "heart").foregroundColor(viewModel.checkChannelIsSaved(channel: channe[indexItem]) ? .red : .white).shadow(color: viewModel.checkChannelIsSaved(channel: channe[indexItem]) ? .black : .white, radius: 4).font(.system(size: 23))
//    }
//    }
    
    
    }

