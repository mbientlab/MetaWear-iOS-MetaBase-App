// Copyright 2021 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import mbientSwiftUI

extension ChooseDevicesScreen {

    /// Populate the screen's list contents
    struct DeviceIterator<SectionDivider: View>: View {

        var divider: SectionDivider

        @EnvironmentObject private var vm: DiscoveryListVM
        @EnvironmentObject private var routing: Routing
        @EnvironmentObject private var factory: UIFactory
        @Namespace private var list

        var body: some View {
            ForEach(vm.groups) { group in
                DeviceCell(.group(group.id), factory: factory)
                    .matchedGeometryEffect(id: group.id, in: list)
            }

            if showDividerA { divider }

            ForEach(vm.ungrouped) { metadata in
                DeviceCell(.known(metadata.id), factory: factory)
                    .matchedGeometryEffect(id: metadata.mac, in: list)
            }

            if showDividerB { divider }

            ForEach(vm.unknown) { deviceID in
                UnknownDeviceCell(unknown: deviceID, factory: factory)
                    .matchedGeometryEffect(id: deviceID.uuidString, in: list)
            }
        }
    }

}

private extension ChooseDevicesScreen.DeviceIterator {

    var showDividerA: Bool {
        vm.groups.isEmpty == false && (vm.ungrouped.isEmpty == false || vm.unknown.isEmpty == false)
    }

    var showDividerB: Bool {
        vm.ungrouped.isEmpty == false && vm.unknown.isEmpty == false
    }
}
