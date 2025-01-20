import SwiftUI

struct TrendsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    Text("Trends")
                        .foregroundStyle(Color.accentColor)
                        .font(.title)
                }
            }
            .navigationTitle("Trends")
        }
    }
}

#Preview {
    TrendsView()
        .preferredColorScheme(.dark)
} 