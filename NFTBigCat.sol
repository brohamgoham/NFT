pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

contract BigCatMohammedAdvancedCryptoNFT is ERC721, VRFConsumerBase {
    uint256 public tokenCounter;
    enum Breed{Lion, Tiger, Cheetah, Jaguar, Leopard, Black_Panther}
    // add other values
    mapping(bytes32 => address) public requestIdToSender;
    mapping(bytes32 => string) public requestIdToTokenURI;
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(bytes32 => uint256) public requestIdToTokenId;
    event requestCollectible(bytes32 indexed requestId);

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash)
    public
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721("Big_Cat", "Roar");
    {
        tokenCounter = 0;
        keyHash = _keyhash;
        fee = 0.1 * 10 **10;
    }
    //who the oracle uses to kick off for knowing what the randomness is with the USerKey, key hash uer prvded seed
    function createCollectibe(string memory tokenURI, uint256 userProvidedSeed) 
        public returns (bytes32){
            bytes32 requestId = requestRandomness(keyHash, fee, userProvidedSeed);
            requestIdToSend[requestId] = msg.sender; 
            requestIdToTokenURI[requestId] = tokenURI;
            emit requestedCollectible(requestId);
    }

    function fufillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        address dogOwner = requestIdToSender[requestId];
        string memory tokenURI = requestIdToTokenURI[requestId];
        uint256 newItemId = tokenCounter;
        _safeMint(dogOwner, newItemId);
        _setTokenURI(newItemId, tokenURI);
        Breed breed = Breed(randomNumber % 6);
        tokenIdToBreed[newItemId] = Breed;

    }

}
