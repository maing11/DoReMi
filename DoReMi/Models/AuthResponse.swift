//
//  AuthResponse.swift
//  DoReMi
//
//  Created by mai ng on 8/18/21.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

//{
//    "access_token" = "BQAXu_CM8W-8nAkPzwyfjSV1C-ulnjT9Kn4OPOpgZPufU0N_3H10lL8y46X-vuHznQw8tYQYAsrCYMlIALI9onATI1gbNFIzaV4QSvnxJsfTXrAvD4pbKlRGblTb9M9PF0UskewFHD_mwVDbq3Q7L1eFliMlY4piU36Al7juEoib7Ks";
//    "expires_in" = 3600;
//    "refresh_token" = "AQBeJWGIuJK-o-6NEJdnQ1I3sEkWwQt_sAFPRBUHjMF0kbPIn_VnmSsHs-_ta1T2sRAEDMcjJ5OpDgJU8DyDvhRNTOYAEGOXtAuzpxLc_OVergExDOOfXRXjKE4LTsjnp3o";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}
