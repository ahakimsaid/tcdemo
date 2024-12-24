//
//  CircleImageView.swift
//  TCDemo-V5
//
//  Created by Abdelhakim SAID on 20/05/2022.
//

import SwiftUI

struct CircleImageView: View {
    var image:Image

    var body: some View {
        image.resizable()
            .clipShape(Circle())
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
            .overlay(Circle().stroke(.white, lineWidth: 4))
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(image: Image("rocket"))
    }
}
