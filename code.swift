// // ContentView.swift // MeCycle 2 // // Created by Fuad Farhan on 1/21/23. //

//  ContentView.swift
//  MeCycle 2
//
//  Created by Fuad Farhan on 1/21/23.
//

import SwiftUI
var useLargeTitle = false
struct ContentView: View {
    @State public var countDownTimer = 100;
    @State var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var progressValue: Float = 0.0

    
    var body: some View { // The timer plus the progress circle
        Color.black //back
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Image(systemName: "lungs") // The logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 95)
                        .foregroundColor(Color.pink)
                    Text("\(countDownTimer)")
                        .onReceive(timer) { _ in
                            if countDownTimer > 0 && timerRunning {
                                countDownTimer -= 1
                                self.progressValue += 0.01
                                if countDownTimer % 5 == 0 { //makes the animation run every 5 seconds
                                        withAnimation {
                                            useLargeTitle.toggle()
                                        }
                                    }
                            } else {
                                timerRunning = false
                            }
                        }
                        .font(.system(size: 80, weight: .bold))
                        .opacity(0.80)
                   
                       
                    HStack(spacing: 20){
                        
                        Button { // Start button makes the counter go down by 1 and the progress go up by 1
                            self.progressValue = 0.01
                            if(progressValue) < 1.0 {
                                countDownTimer-=1
                                self.progressValue += 0.01
                            }
                            timerRunning = true
                        } label : {
                            Label("Start", systemImage: "aqi.medium")
                        }
                        
                        .frame(height: 55)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        Button { // restart
                            countDownTimer = 100
                            timerRunning = false
                            if(progressValue) < 1.0 {
                                progressValue -= 0.99
                            }
                        } label : {
                            Label("Restart", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .frame(height: 55)
                        .buttonStyle(.bordered)
                        .tint(.red)
                        .controlSize(.large)
                        
                        
                        
                    }
                    
                    ProgressBar(progress: self.$progressValue)
                        .frame(width:250.0, height:250.0)
                        .padding(20.0).onAppear(){
                            self.progressValue = 0.01
                        }
                    
                    
                    .foregroundColor(Color.white)
                    
                })
            .foregroundColor(Color.white)
                }
    
            
    }


struct ProgressBar: View {   //progress circle
    @Binding var progress: Float
    var color: Color = Color.pink
    @State public var countDownTimer = 100;
    @State var progressValue: Float = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timerRunning = false
    
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
            
                VStack(spacing: 20) {
                    ZStack {
                                
                        
                        
                        
                        Circle() // the outer circle
                            .stroke(lineWidth: 28.0)
                            .opacity(0.45)
                            .foregroundColor(Color.blue)
                            .padding()
                        
                        Circle() // the filling
                            .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(color)
                            .rotationEffect(Angle(degrees: 270))
                            .animation(.easeInOut(duration: 2.0))
                            .padding()
                    }
                    
                    VStack {
                        
                       
                        Text("Breathe")
                            .font(useLargeTitle ? .largeTitle : .body)
                            .fontWeight(useLargeTitle ? .ultraLight : .black)
                            .onTapGesture {
                                withAnimation{
                                    useLargeTitle.toggle()
                                }
                                
                            }
                            
    
                            
                            
                    }
                    
                    
                    
                })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
