//
//  ChannelsView.swift
//  SverigesRadioApp-SwiftUI
//
//  Created by Nureddin Elmas on 2022-01-14.
//

import SwiftUI
import AVFoundation

struct ChannelsView: View {
    @State var myChannel:Channels
    @State var isPlaying = true
    @State var player:AVPlayer?
    @State var sliderValue: Float = 0
    
    var playerItem:AVPlayerItem?
    var audioPlayer = AVAudioPlayer()
    var body: some View {
        HStack{
            VStack{
                ImageView(imageString: myChannel.imagetemplate)
                ZStack{
                    Circle().foregroundColor(Color.blue).frame(width: 40, height: 40, alignment: .center).foregroundColor(Color.black.opacity(0.2))
                    Image(systemName: isPlaying ? "play" : "pause")
                }.onTapGesture {
                    playing()
//                    sliderValue = player!.volume
                }
//                Slider(value: $sliderValue, in: 0...100, step: 1).accentColor(Color.green)
//                Text("Current Slider Value : \(sliderValue, specifier: "%1f")")
            }
//            SliderView(sliderProgress: player?.volume)
        }

        
    }
    
    private func playing(){
        let playerItem:AVPlayerItem = AVPlayerItem(url: URL(string: myChannel.liveaudio.url)!)
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

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hej")
//        ChannelsView(myChannel: Channels)
    }
}
