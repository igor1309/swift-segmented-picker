//
//  SegmentedPicker.swift
//  CustomSegmentedPicker
//
//  Created by Igor Malyarov on 05.03.2023.
//

import SwiftUI

struct SegmentedPicker<Tag, TagView>: View
where Tag: Identifiable & Hashable,
      TagView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    private let tagView: (Tag, Bool) -> TagView
    @Namespace private var namespace
    
    init(
        viewModel: ViewModel,
        tagView: @escaping (Tag, Bool) -> TagView
    ) {
        self.viewModel = viewModel
        self.tagView = tagView
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.tags, content: tagView)
            }
        }
    }
}

extension SegmentedPicker {
    
    @ViewBuilder
    private func tagView(tag: Tag) -> some View {
        
        let isSelected = viewModel.selectedTag == tag
        
        tagView(tag, isSelected)
            .id(tag.id)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background {
                Color.gray.opacity(isSelected ? 0.2 : 0.05)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .matchedGeometryEffect(
                        id: "selection",
                        in: namespace,
                        properties: [.frame, .position, .size],
                        anchor: .center,
                        isSource: isSelected // ?????
                    )
            }
            .onTapGesture {
                withAnimation {
                    viewModel.select(tag: tag)
                }
            }
    }
}

extension SegmentedPicker {
    
    final class ViewModel: ObservableObject {
        
        @Published private(set) var selectedTag: Tag
        
        let tags: [Tag]
        
        init(selectedTag: Tag, tags: [Tag]) {
            self.selectedTag = selectedTag
            self.tags = tags
        }
        
        func select(tag: Tag) {
            
            self.selectedTag = tag
        }
    }
}

// MARK: - Preview Content

private struct PreviewTag: Identifiable & Hashable {
    
    let title: String
    var id: String { title }
}

private extension PreviewTag {
    
    static let tagA: Self = .init(title: "Aaa")
    static let tagB: Self = .init(title: "Bbb")
    static let tagC: Self = .init(title: "Ccc")
    static let tagD: Self = .init(title: "Ddd")
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker(
            viewModel: .init(
                selectedTag: PreviewTag.tagB,
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
