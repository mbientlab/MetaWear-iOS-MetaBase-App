// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import mbientSwiftUI
import Combine
import MetaWear
import MetaWearSync

struct ActionScreen: View {

    @StateObject private var vm: ActionVM
    @State private var nameWidth = CGFloat(80)

    init(_ factory: UIFactory) {
        _vm = .init(wrappedValue: factory.makeActionVM())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ActionHeader(vm: vm)
                .keyboardShortcut(.cancelAction)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(vm.deviceVMs) { vm in
                        Row(vm: vm, nameWidth: nameWidth)
                    }
                    .animation(.easeOut, value: vm.actionFocus)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, .screenInset)
            .onPreferenceChange(NameWK.self) { nameWidth = $0 }

            CTAs()
                .padding(.bottom, .screenInset)
                .padding(.horizontal, .screenInset)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environmentObject(vm)
        .onAppear(perform: vm.onAppear)
    }
}
