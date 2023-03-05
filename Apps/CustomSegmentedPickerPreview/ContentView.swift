//
//  ContentView.swift
//  CustomSegmentedPickerPreview
//
//  Created by Igor Malyarov on 05.03.2023.
//

import CustomSegmentedPicker
import SwiftUI

struct ContentView: View {
    var body: some View {
        
        SegmentedPicker(
            viewModel: .init(
                selectedTag: Tag.tagB,
                tags: [
                    .tagA,
                    .tagB,
                    .tagC,
                    .tagD,
                ]
            ),
            tagView: { tag, isSelected in
                Text(tag.title)
                    .foregroundColor(isSelected ? .primary : .secondary)
            }
        )
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

private struct Tag: Identifiable & Hashable {
    
    let title: String
    var id: String { title }
}

private extension Tag {
    
    static let tagA: Self = .init(title: "Aaa")
    static let tagB: Self = .init(title: "Bbb")
    static let tagC: Self = .init(title: "Ccc")
    static let tagD: Self = .init(title: "Ddd")
}
