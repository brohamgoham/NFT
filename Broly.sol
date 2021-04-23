pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BROLY is ERC721 {

    constructor () public ERC721("LSSBROLY"){
        tokenCounter = 0;

    }

    function createCollectible(string memory tokenURI) public return (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenUri);
        tokenCounter = tokenCounter +1;
        return newItemId;
    }

}
