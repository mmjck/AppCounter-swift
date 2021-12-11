//
//  ContentView.swift
//  AppCounter
//
//  Created by Jackson Matheus dos Santos on 08/12/21.
//

import SwiftUI
class Counter : ObservableObject {
    
    @Published var days  = 0
    @Published var years  = 0
    @Published var months  = 0
    @Published var minutes  = 0
    @Published var second  = 0
    @Published var hours  = 0

    @Published var selectDate  = Date()

    
    init(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true ){ timer in
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            let selectComponent = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectDate)
            
            
            var eventDateComponent = DateComponents()
            eventDateComponent.year = selectComponent.year
            eventDateComponent.month = selectComponent.month
            eventDateComponent.day = selectComponent.day
            eventDateComponent.hour = selectComponent.hour
            eventDateComponent.minute = selectComponent.minute
            eventDateComponent.second = selectComponent.second
            
            
            let eventDate = calendar.date(from: eventDateComponent)
            
            
            let timeLeft = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if(timeLeft.second! >= 0){
                self.days = timeLeft.day ?? 0
                self.minutes = timeLeft.minute ?? 0
                self.hours = timeLeft.hour ?? 00
                self.second = timeLeft.second ?? 00
            }
                
        }
        
        
        
    }
}



struct ContentView: View {
    @StateObject var counter = Counter();
    var body: some View {
        VStack{
            
            
            DatePicker(selection: $counter.selectDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]){
                Text("Selecione a data: ")

            }
            
            
            HStack{
                Text("\(counter.days) dias")
                    .padding()
                    .background(Color.blue)
                Text("\(counter.hours) horas")
                Text("\(counter.minutes) min")
                Text("\(counter.second) seg")
            }
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
