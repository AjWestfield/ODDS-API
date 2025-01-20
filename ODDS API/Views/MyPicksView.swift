import SwiftUI

struct MyPicksView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    Text("My Picks")
                        .foregroundStyle(Color.accentColor)
                        .font(.title)
                }
            }
            .navigationTitle("My Picks")
        }
    }
}

#Preview {
    MyPicksView()
        .preferredColorScheme(.dark)
} 