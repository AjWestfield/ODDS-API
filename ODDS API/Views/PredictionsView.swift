import SwiftUI

struct PredictionsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    Text("Predictions")
                        .foregroundStyle(Color.accentColor)
                        .font(.title)
                }
            }
            .navigationTitle("Predictions")
        }
    }
}

#Preview {
    PredictionsView()
        .preferredColorScheme(.dark)
} 