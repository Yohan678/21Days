//
//  HabitBoxView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/9/25.
//

import SwiftUI

struct HabitBoxView: View {
    
    let boxIndex: Int
    let isFilled: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(isFilled ? .mint : .gray.opacity(0.3))
            .frame(width: 40, height: 40)
            .overlay(
                Text("\(boxIndex + 1)")
                    .font(.caption)
                    .foregroundColor(isFilled ? .white : .black)
            )
        
        
    }
}

#Preview {
    HabitBoxView(boxIndex: 3, isFilled: false)
}
