//
//  ContentView.swift
//  CollectionView
//
//  Created by App-Designer2 . on 17.02.20.
//  Copyright © 2020 App-Designer2. All rights reserved.
//

import SwiftUI
import ASCollectionView

struct User: Identifiable, Hashable {
    let id : Int
    var imag,names,prices,before: String
}

struct ContentView: View {
    var image :
        [User] = [
            .init(id: 0, imag: "room0", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1800", before: "€1900"),
    
            .init(id: 1, imag: "room1", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1750", before: "€1800"),
    
            .init(id: 2, imag: "room2", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1700", before: "€1750"),
    
            .init(id: 3, imag: "room3", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1650", before: "€1700"),
    
            .init(id: 4, imag: "room4", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1600", before: "€1650"),
    
            .init(id: 5, imag: "room5", names: "Once all the “fun” of moving subsides – and you’ve finally got the Wi-Fi", prices: "€1550", before: "€1600")
    ]
    
    var images  = ["room4","room5","room6","room7","room8","room1"]
    
    @State var favo = false

    var body: some View {
        NavigationView {
             ASCollectionView
                   {
                    ASCollectionViewSection(
                        id: 1,
                        data: images,
                        dataID: \.self)
                    { item, _ in
                        Color.green
                            .overlay(
                             Image(item).resizable()
                            )
                    }
                    //At first you have to import the librery
                    
                       ASCollectionViewSection(
                           id: 0,
                           data: image,
                           dataID: \.self)
                       { item, _ in
                           
                        VStack(alignment: .leading, spacing: 12) {
                                Image(item.imag).resizable()
                                .cornerRadius(12)
                            VStack(alignment: .leading) {
                                Text(item.names)
                                .bold()
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("V/\(item.prices)")
                                            .foregroundColor(.red)
                                        
                                        Text(item.before).strikethrough(true, color: .gray)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                        Button(action: {}) {
                        Text("See")
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                            
                                    }
                        }
                            }
                            
                        }//VStack
                       }
                        .sectionHeader
                        {
                            VStack(alignment: .leading)
                            {
                                Text("Collections")
                             .bold()
                                 .font(.title)
                                    .padding(2)
                                 .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 0)
                                Spacer()
                            }.padding(.leading)
                            .background(Color(red: 55/255, green: 50/255, blue: 150.4/255))
                            
                        }
                       
                       .sectionFooter
                       {
                           Text("powered by App-Designer2")
                            .foregroundColor(.secondary)
                               .padding()
                       }
                   }
                   .layout { sectionID in
                       switch sectionID {
                           case 0:
                           // Here we use one of the provided convenience layouts
                           return .grid(layoutMode: .adaptive(withMinItemSize: 200),
                                        itemSpacing: 6,
                                        lineSpacing: 8,
                                        itemSize: .absolute(260))
                           default:
                           return ASCollectionLayoutSection
                           { environment in
                               let isWide = environment.container.effectiveContentSize.width > 600
                               let gridBlockSize = environment.container.effectiveContentSize.width / (isWide ? 4 : 3)
                               let gridItemInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                               let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize), heightDimension: .absolute(gridBlockSize))
                               let item = NSCollectionLayoutItem(layoutSize: itemSize)
                               item.contentInsets = gridItemInsets
                               let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize), heightDimension: .absolute(gridBlockSize * 2))
                               let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: item, count: 2)

                               let featureItemSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize * 2), heightDimension: .absolute(gridBlockSize * 2))
                               let featureItem = NSCollectionLayoutItem(layoutSize: featureItemSize)
                               featureItem.contentInsets = gridItemInsets

                               let verticalAndFeatureGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize * 2))
                               let verticalAndFeatureGroupA = NSCollectionLayoutGroup.horizontal(layoutSize: verticalAndFeatureGroupSize, subitems: isWide ? [verticalGroup, verticalGroup, featureItem, verticalGroup] : [verticalGroup, featureItem])
                               let verticalAndFeatureGroupB = NSCollectionLayoutGroup.horizontal(layoutSize: verticalAndFeatureGroupSize, subitems: isWide ? [verticalGroup, featureItem, verticalGroup, verticalGroup] : [featureItem, verticalGroup])

                               let rowGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize))
                               let rowGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rowGroupSize, subitem: item, count: isWide ? 5 : 3)

                               let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize * 6))
                               let outerGroup = NSCollectionLayoutGroup.vertical(layoutSize: outerGroupSize, subitems: [verticalAndFeatureGroupA, rowGroup, verticalAndFeatureGroupB, rowGroup])

                               let section = NSCollectionLayoutSection(group: outerGroup)

                               let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
                               let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                                   layoutSize: supplementarySize,
                                   elementKind: UICollectionView.elementKindSectionHeader,
                                   alignment: .top)
                               let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                                   layoutSize: supplementarySize,
                                   elementKind: UICollectionView.elementKindSectionFooter,
                                   alignment: .bottom)
                               section.boundarySupplementaryItems = [headerSupplementary, footerSupplementary]
                               return section
                           }
                       }
             }.navigationBarTitle("CollectionView", displayMode: .large)
        }.colorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//struct collectionView : UIViewControllerRepresentable {
//
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<collectionView>) -> UIViewControllerType {
//
//        let collection = UICollectionViewCell()
//        collection.backgroundView = .init(frame: .zero)
//        collection.isSelected = true
//    }
//    func updateUIViewController(_ uiViewController: collectionView.UIViewControllerType, context: UIViewControllerRepresentableContext<collectionView>) {
//
//    }
//}
