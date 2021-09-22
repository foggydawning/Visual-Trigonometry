//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    let spacer_20 = Spacer(minLength: UIScreen.main.bounds.height/20)
    
    var body: some View {
        HStack{
            Spacer(minLength: 15)
            VStack(alignment: .center){
                ZStack{
                    trigonometry_view()
                }
                
                Spacer()
            }
            
            Spacer(minLength: 15)
            
        }
    }
}

struct trigonometry_view: View{
    var width: CGFloat = UIScreen.main.bounds.width - 30
    var height: CGFloat {
        width
    }

    var body: some View{
        ZStack{
            circle(radius: width/2-5, center: CGPoint(x: width/2, y: height/2))
                .stroke(lineWidth: 3)
                .frame(alignment: .center)
                .frame(width: width, height: height, alignment: .center)
        }
        
    }
}

struct circle: Shape {
    var radius: CGFloat
    var center: CGPoint
    
    init(radius: CGFloat, center: CGPoint){
        self.radius = radius
        self.center = center
    }
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.addArc(center: self.center, radius: self.radius, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360.0), clockwise: true)
        return path
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
