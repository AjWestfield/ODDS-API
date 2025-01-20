import SwiftUI

struct LeagueButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var logoName: String {
        switch title {
        case "NBA": return "_NBA_logo"
        case "NFL": return "_NFL_logo"
        case "MLB": return "_MLB_logo"
        case "NCAAB": return "ncaab_logo"
        case "NCAAF": return "ncaaf_logo"
        case "NHL": return "nhl_logo"
        default: return ""
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(logoName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? Color.accentColor : .white)
            .background(
                Capsule()
                    .stroke(isSelected ? Color.accentColor : Color.white.opacity(0.3), lineWidth: 1.5)
                    .background(isSelected ? Color.black : Color.white.opacity(0.1))
                    .clipShape(Capsule())
            )
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HStack {
            LeagueButton(title: "NBA", isSelected: true) {}
            LeagueButton(title: "NFL", isSelected: false) {}
        }
    }
} 