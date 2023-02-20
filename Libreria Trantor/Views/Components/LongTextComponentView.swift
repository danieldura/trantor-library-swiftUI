//
//  LongTextComponentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 17/2/23.
//

import SwiftUI

struct LongTextComponentView: View {
    @State private var isScaled = false
    @GestureState private var gestureScale: CGFloat = 1.0
    var longText = "Texto largo aquí ..."
    
    var body: some View {
        VStack (spacing:0){
            Text(longText)
                .font(.body)
                .lineLimit(isScaled ? nil : 3)
                .scaleEffect(isScaled ? gestureScale : 1)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .updating($gestureScale) { currentState, gestureState, transaction  in
                        }
                        .onEnded { _ in
                            withAnimation {
                                isScaled.toggle()
                            }
                        }
            )
            Button {
                withAnimation {
                    isScaled.toggle()
                }
                
            } label: {
                Label(isScaled ? "Leer menos".localized: "Leer más".localized, systemImage: isScaled ? "minus.circle" : "plus.circle")
            }
        }
        

    }
}

struct LongTextComponentView_Previews: PreviewProvider {
    static var previews: some View {
        LongTextComponentView(longText: "The Island of Doctor Moreau is the account of Edward Prendick, an Englishman with a scientific education who survives a shipwreck in the southern Pacific Ocean. A passing ship takes him aboard, and a man named Montgomery revives him. Prendick also meets a grotesque bestial native named M'ling, who appears to be Montgomery's manservant. The ship is transporting a number of animals which belong to Montgomery. As they approach the island, Montgomery's destination, the captain demands Prendick leave the ship with Montgomery. Montgomery explains that he will not be able to host Prendick on the island. Despite this, the captain leaves Prendick in a dinghy and sails away. Seeing that the captain has abandoned Prendick, Montgomery takes pity and rescues him. As ships rarely pass the island, Prendick will be housed in an outer room of an enclosed compound.\nThe island belongs to Dr. Moreau. Prendick remembers that he has heard of Moreau, formerly an eminent physiologist in London whose gruesome experiments in vivisection had been publicly exposed and has fled England as a result of his exposure.\nThe next day, Moreau begins working on a puma. Prendick gathers that Moreau is performing a painful experiment on the animal, and its anguished cries drive Prendick out into the jungle. While he wanders, he comes upon a group of people who seem human but have an unmistakable resemblance to swine. As he walks back to the enclosure, he suddenly realises he is being followed by a figure in the jungle. He panics and flees, and the figure gives chase. As his pursuer bears down on him, Prendick manages to stun him with a stone and observes the pursuer is a monstrous hybrid of animal and man. When Prendrick returns to the enclosure and questions Montgomery, Montgomery refuses to be open with him. After failing to get an explanation, Prendick finally gives in and takes a sleeping draught.\nPrendick awakes the next morning with the previous night's activities fresh in his mind. Seeing that the door to Moreau's operating room has been left unlocked, he walks in to find a humanoid form lying in bandages on the table before he is ejected by a shocked and angry Moreau. He believes that Moreau has been vivisecting humans and that he is the next test subject. He flees into the jungle where he meets an Ape-Man who takes him to a colony of similarly half-human/half-animal creatures. Their leader is a large grey thing named the Sayer of the Law who has him recite a strange litany called the Law that involves prohibitions against bestial behavior and praise for Moreau.\nSuddenly, Dr. Moreau bursts into the colony looking for Prendick, but Prendick escapes to the jungle. He makes for the ocean, where he plans to drown himself rather than allow Moreau to experiment on him. Moreau explains that the creatures called the Beast Folk were not formerly men, but rather animals. Prendick returns to the enclosure, where Moreau explains that he has been on the island for eleven years and has been striving to make a complete transformation of an animal to a human. He explains that while he is getting closer to perfection, his subjects have a habit of reverting to their animal form and behaviour. Moreau regards the pain he inflicts as insignificant and an unavoidable side effect in the name of his scientific experiments.\nOne day, Prendick and Montgomery encounter a half-eaten rabbit. Since eating flesh and tasting blood are strong prohibitions, Dr. Moreau calls an assembly of the Beast Folk and identifies the Leopard-Man (the same one that chased Prendick the first time he wandered into the jungle) as the transgressor. Knowing that he will be sent back to Dr. Moreau's compound for more painful sessions of vivisection, the Leopard-Man flees. Eventually, the group corners him in some undergrowth, but Prendick takes pity and shoots him to spare him from further suffering. Prendick also believes that although the Leopard-Man was seen breaking several laws, such as drinking water bent down like an animal, chasing men (Prendick), and running on all fours, the Leopard-Man was not solely responsible for the deaths of the rabbits. It was also the Hyena-Swine, the next most dangerous Beast Man on the island. Dr. Moreau is furious that Prendick killed the Leopard-Man but can do nothing about the situation.\nAs time passes, Prendick becomes inured to the grotesqueness of the Beast Folk. However one day, the half-finished puma woman rips free of her restraints and escapes from the lab. Dr. Moreau pursues her, but the two end up fighting each other which ends in a mutual kill. Montgomery breaks down and decides to share his alcohol with the Beast Folk. Prendick resolves to leave the island, but later hears a commotion outside in which Montgomery, his servant M'ling, and the Sayer of the Law die after a scuffle with the Beast Folk. At the same time, the compound burns down because Prendick has knocked over a lamp. With no chance of saving any of the provisions stored in the enclosure, Prendick realizes that during the night Montgomery has also destroyed the only boats on the island.\nPrendick lives with the Beast Folk on the island for months after the deaths of Moreau and Montgomery. As the time goes by, the Beast Folk increasingly revert to their original animal instincts, beginning to hunt the island's rabbits, returning to walking on all fours, and leaving their shared living areas for the wild. They cease to follow Prendick's instructions and eventually the Hyena-Swine kills his faithful companion, a Dog-Man created from a St. Bernard. Prendick then shoots the Hyena-Swine in self-defence with the help of the Sloth Creature. Luckily for Prendick ever since his efforts to build a raft have been unsuccessful, a boat that carries two corpses drifts onto the beach (perhaps the captain of the ship that picked Prendick up and a sailor). Prendick uses the boat to leave the island and is picked up three days later. But when he tells his story he is thought to be mad, so he feigns amnesia.\nBack in England, Prendick is no longer comfortable in the presence of humans who seem to him to be about to revert to the animal state. He leaves London and lives in near-solitude in the countryside, devoting himself to chemistry as well as astronomy in the studies of which he finds some peace.")
    }
}
