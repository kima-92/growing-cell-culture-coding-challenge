//
//  Rules.swift
//  Growing Cells in a Medium
//
//  Created by macbook on 2/19/21.
//

import Foundation

/*
 ---------------------  Growing Cell Cultures ---------------------
     
     
     Zones which were Livable have a chance for the culture to take hold and grow. The culture takes hold according to a specific set of rules.
     
-------------------------------------------------------------------
 
    Rules:
     
     1.    The cells require room to blossom, so if a livable area is empty and there are no adjacent cell cultures, the cells will take hold and begin to grow
     
         *    Live - Blossom - Grow - Culture
         
         * If livable (L) and has no adjacent culture (#) -> it will grow into (#)
         
         
     2.    The cells are also subject to crowding, so if a culture is growing in a location where four or more adjacent locations are also occupied, then the culture dies back
     
         * Dies - Culture dies
         
         * If culture (#) in location where 4+ adjacent cultures (#)s -> it dies back to (L)
         
     
     3.    Otherwise, no change occurs
         
         * No changes
         
         * else, no changes ->  (L) = (L)   ||   (#) = (#)
         
     
     4.    Unlivable spaces are never occupied with a culture
     
         * Dead is Dead
         
         * (.) stays as (.)
 */
