import SwiftUI

struct SplitView: View {
    
    @FocusState private var amountIsFocus: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var percentage = 20
    
    let tipPercentages = [0,5, 10, 15, 20, 25]
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.numberPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 16) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Type percentage", selection: $percentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocus = false
                    }
                }
            }
        }
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(percentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
