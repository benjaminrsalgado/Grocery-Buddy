// ContentView.swift
// fruits

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemTeal).opacity(0.15),
                                            Color(.systemYellow).opacity(0.10)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ListaTarea()
                .padding()
        }
    }
}

struct ListaTarea: View {
    @State var tareas = [
        "🍎 Manzana","🍐 Pera","🍊 Naranja","🍋 Limón","🍌 Plátano","🍉 Sandía",
        "🍇 Uvas","🍓 Fresa","🫐 Arándanos","🍒 Cereza","🍑 Durazno","🥭 Mango",
        "🍍 Piña","🥥 Coco","🥝 Kiwi","🍈 Melón","🍅 Tomate","🥑 Aguacate",
        "🌽 Maíz","🥕 Zanahoria","🥦 Brócoli","🍆 Berenjena","🌶️ Chile","🥔 Papa"
    ]


    @State private var animatingIndex: Int? = nil

    
    @State private var nuevoItem: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

            
                HStack(spacing: 10) {
                    TextField("Add element", text: $nuevoItem)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit { agregarItem() }

                    Button("Add") { agregarItem() }
                        .buttonStyle(.borderedProminent)
                        .disabled(nuevoItem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.vertical, 4)

                ForEach(tareas.indices, id: \.self) { index in
                    let isMarked = tareas[index].hasPrefix("✅ ")
                    HStack {
                        Text(tareas[index])
                            .font(.headline)
                            .foregroundColor(isMarked ? .gray : .primary)
                            .strikethrough(isMarked, color: .gray)
                            .animation(.easeInOut, value: isMarked)

                        Spacer()

                        Button(isMarked ? "Add to List" : "Added") {
                            if !isMarked {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                    tareas[index] = "✅ " + tareas[index]
                                    animatingIndex = index
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    animatingIndex = nil
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                        .disabled(isMarked)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground).opacity(0.95))
                            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                    )
                    .scaleEffect(animatingIndex == index ? 1.04 : 1.0)
                    .animation(.spring(), value: animatingIndex == index)
                }
            }
            .padding(.vertical)
        }
    }

   
    private func agregarItem() {
        let texto = nuevoItem.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !texto.isEmpty else { return }
        tareas.append(texto)
        nuevoItem = ""
    }
}

#Preview {
    ContentView()
}

