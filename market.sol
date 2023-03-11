// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFTMarketplace is ReentrancyGuard {

    address payable  public immutable feeAccount;
    uint public imutable feepercent;
    uint public itemcount;
    struct item{
        uint _itemIds;
        IERC721 nft;
        uint tokenid;
        uint price;
        address payable seller;
        bool sold;
     }
     event offered{
         uint _itemIds;
        IERC721 nft;
        uint tokenid;
        uint price;
        address payable seller;

     }
     mapping (uint=>item)public item;

    constructor(uint _feepercent){
        feeAccount= payable (msg.sender);
        feepercent=_feepercent;
    }
    function createMarketSale(
    address nftContract,
    uint256 itemId
    ) public payable nonReentrant {
    uint price = idToMarketItem[itemId].price;
    uint tokenId = idToMarketItem[itemId].tokenId;
    require(msg.value == price, "submit theasking prise for sell");

    idToMarketItem[itemId].seller.transfer(msg.value);
    IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
    idToMarketItem[itemId].owner = payable(msg.sender);
    idToMarketItem[itemId].sold = true;
    _itemsSold.increment();
    payable(owner).transfer(listingPrice);
  }
    function makeitem(IERC721 _nft, uint _tokenid, uint _price)external non Reentrant{
        require(price =0, "price must be greater then 0");
        itemcount++;
        _nft.transferfrom(msg.sender, address(this),tokenid);
        item(itemcount) = item{
            itemcount,
            _nft,
            _tokenid,
            _price,
            payable (msg.sender), 
            false
           };
           
           mint offered{
            itemcount,
            address(nft),
            _tokenid,
            _price,
            msg.sender 
           };
    function sellMarketItems() public view returns (MarketItem[] memory) {
    uint itemCount = _itemIds.current();
    uint unsoldItemCount = _itemIds.current() - _itemsSold.current();
    uint currentIndex = 0;

    MarketItem[] memory items = new MarketItem[](unsoldItemCount);
    for (uint i = 0; i < itemCount; i++) {
      if (idToMarketItem[i + 1].owner == address(0)) {
        uint currentId = i + 1;
        MarketItem storage currentItem = idToMarketItem[currentId];
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    return items;
    }
    }
    function auction() public view returns (MarketItem[] memory) {
    uint totalItemCount = _itemIds.current();
    uint itemCount = 0;
    uint currentIndex = 0;

    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].seller == msg.sender) {
        itemCount += 1;
      }
    }

    MarketItem[] memory items = new MarketItem[](itemCount);
    for (uint i = 0; i < totalItemCount; i++) {
      if (idToMarketItem[i + 1].seller == msg.sender) {
        uint currentId = i + 1;
        MarketItem storage currentItem = idToMarketItem[currentId];
        items[currentIndex] = currentItem;
        currentIndex += 1;
      }
    }
    return items;
  }
}
}

  