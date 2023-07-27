//
//  SelectCountryView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/15/23.
//

import SwiftUI

struct SelectCountryView: View {
    
    @Binding var countryChosen: Country
    
    @Environment(\.dismiss) var dismiss
    
    var countries: [Country] = Country.allCountries
    
    var body: some View {
        VStack{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Text("Select Country")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack{
                    VStack{
                        List{
                            Section{
                                ForEach(countries, id: \.isoCode){ country in
                                    HStack{
                                        Text("\(country.flag(country: country.isoCode)) \(country.localizedName) (+\(country.phoneCode))" )
                                        
                                        Spacer()
                                        
                                        if country.isoCode == countryChosen.isoCode {
                                            Image(systemName: "checkmark.circle")
                                        }
                                    }
                                    .onTapGesture {
                                        countryChosen = country
                                        dismiss()
                                    }
                                }
                            }
                        header: {
                            Text("SUGGESTED")
                                .padding(.leading, -8)
                                .font(.system(size: 12))
                        }
                        }
                    }
                }
                .padding(.top, 50)
            }
            .environment(\.colorScheme, .dark)
        }
    }
}

//struct SelectCountryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectCountryView()
//    }
//}
