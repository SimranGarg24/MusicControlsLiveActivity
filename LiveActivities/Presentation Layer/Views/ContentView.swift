//
//  ContentView.swift
//  LiveActivities
//
//  Created by ChicMic on 10/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        
        VStack {
            
            Spacer()
            Image(vm.song[vm.index].songImage)
                .resizable()
                .frame(width: 350,height: 400)
                .cornerRadius(20)
            
            Spacer()
            Text(vm.song[vm.index].songName)
                .font(.system(size: 25,weight: .bold))
            
            Spacer()
            
            VStack {
                Slider(value: $vm.sliderValue,
                       in: TimeInterval(0.0)...vm.song[vm.index].duration, onEditingChanged: { start in
                    
                    //when editing begins - start is equal to true
                    //when editing ends - start is equal to false
                    
                    //stop timer so that the slider value doesn't automatically changes when user is interacting with the slider.
                    vm.stopTimer()
                    
                    //when editing ends, change song current time
                    if !start {
                        print(vm.sliderValue)
                        vm.changeSongPosition()
                    }
                })
                .tint(.black)
                .onReceive(vm.timer) { _ in
                    vm.changeSliderValue()
                }
                
                HStack(alignment: .center) {
                    Text(vm.song[vm.index].singername)
                        .font(.system(size: 18))
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25,height: 25)
                }
                
            }
            Spacer()
            
            HStack{
                Spacer()
                Button {
                    vm.previousSong()
                } label: {
                    Image(systemName: "backward.end")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                
                
                Spacer()
                Button {
                    vm.isPaused = !vm.isPaused
                    vm.playPauseSong()
                } label: {
                    Image(systemName: vm.isPaused ? "play.fill" : "pause.fill")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                Spacer()
                Button {
                    vm.nextSong()
                } label: {
                    Image(systemName: "forward.end")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .shadow(color: .gray, radius: 20)
                }
                .tint(.black)
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            
            vm.setupNotificationCenter()
            vm.player.setAVPlayer(songFile: vm.song[vm.index].songFile)
            MediaPlayerNotification.shared.setupNotificationView(song: vm.song[vm.index])
        }
        .padding()
        .background(LinearGradient(colors: [.gray.opacity(0.5),.gray.opacity(0.2)], startPoint: .bottomTrailing, endPoint: .topLeading))
        .cornerRadius(20)
        .shadow(radius: 10)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
