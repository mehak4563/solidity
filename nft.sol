//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.15;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    uint public tokencount;
    constructor() ERC721("mehak nft","meh"){
        
        function mint(string memory _tokenURI) external return (uint){
            tokencount++;
            _safeMint(msg.sender, tokencount);
            _setTokenURI(tokencount, _tokenURI);
            return (tokencount);
        }
    }
}
