import CryptoKit
import UIKit

// (Steve X) MARK: - AES Symmetric Encryption
// (Steve X) MARK: Encryption
let plainText = "Hello, playground".data(using: .utf8) ?? Data()
let digest = SHA256.hash(data: plainText)
let secretKey = SymmetricKey(size: .bits256)
let sealedBox = try? AES.GCM.seal(plainText, using: secretKey)
let cipherData = sealedBox?.ciphertext

// (Steve X) MARK: For transmission
let nonce = sealedBox?.nonce
let tag = sealedBox?.tag
let cipherBase64Str = cipherData?.base64EncodedString()

// (Steve X) MARK: Decryption
let decodedCipher = Data(base64Encoded: cipherBase64Str ?? "")
let decodedSealBox = try! AES.GCM.SealedBox(
    nonce: nonce.unsafelyUnwrapped,
    ciphertext: decodedCipher.unsafelyUnwrapped,
    tag: tag.unsafelyUnwrapped
)

let decryptedData = try? AES.GCM.open(decodedSealBox, using: secretKey)
let decryptedText = String(data: decryptedData ?? Data(), encoding: .utf8)

// (Steve X) MARK: - ECC Asymmetric Encryption & KeyGen
// (Steve X) TODO: [DISSERTATION]: Compare NIST P256/P384/P521 & Curve25519
// For User A
let priA = Curve25519.KeyAgreement.PrivateKey()
let priABase64Str = priA.rawRepresentation.base64EncodedString()
let pubA = priA.publicKey
let pubABase64Str = pubA.rawRepresentation.base64EncodedString()

// For User B
let priB = Curve25519.KeyAgreement.PrivateKey()
let priBBase64Str = priB.rawRepresentation.base64EncodedString()
let pubB = priB.publicKey
let pubBBase64Str = pubB.rawRepresentation.base64EncodedString()

// (Steve X) MARK: For transmission
let pubAData = Data(base64Encoded: pubABase64Str)
let pubADecoded = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: pubAData ?? Data())
let pubBData = Data(base64Encoded: pubBBase64Str)
let pubBDecoded = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: pubBData ?? Data())
pubADecoded.rawRepresentation == pubA.rawRepresentation
pubBDecoded.rawRepresentation == pubB.rawRepresentation

// (Steve X) MARK: Key Generate
let secKeyA = try? priA.sharedSecretFromKeyAgreement(with: pubBDecoded)
let secKeyB = try? priB.sharedSecretFromKeyAgreement(with: pubADecoded)
secKeyA == secKeyB
