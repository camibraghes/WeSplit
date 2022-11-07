import SwiftUI

struct TemperatureConversion: View {
    
    @State var inputTemperature = 0.0
    @State var inputUnits = "Celsius"
    @State var outputUnits = "Celsius"
    
    @FocusState var inputTemperatureFocused: Bool
    
    let temperatureType = ["Celsius", "Fahrenheit", "Kelvin"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Units", selection: $inputUnits) {
                        ForEach(temperatureType, id: \.self) {
                            Text("º\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Units")
                }
                
                Section {
                    TextField("Temperature in \(inputUnits)º", value: $inputTemperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputTemperatureFocused)
                    
                }
                
                Section {
                    Picker("Units", selection: $outputUnits) {
                        ForEach(temperatureType, id:\.self){
                            Text("º\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(outputTemperature, format: .number)
                }
            }
            .navigationTitle("Temperature Convert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputTemperatureFocused = false
                    }
                }
            }
        }
    }
    
    var outputTemperature: Double {
        var temperatureInCelsius = 0.0
        
        if inputUnits == "Fahrenheit" {
            temperatureInCelsius = (inputTemperature - 32) * 5/9
        } else if inputUnits == "Kelvin" {
            temperatureInCelsius = inputTemperature - 273.15
        } else {
            temperatureInCelsius = inputTemperature
        }
        
        if outputUnits == "Fahrenheit" {
            return temperatureInCelsius * 9/5 + 32
        } else if outputUnits == "Kelvin" {
            return temperatureInCelsius + 273.15
        } else  {
            return temperatureInCelsius
        }
    }
}

struct TemperatureConversion_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversion()
    }
}
