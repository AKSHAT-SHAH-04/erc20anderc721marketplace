pragma solidity >=0.7.0 <0.8.0;

import "./CardToken.sol";
import "./NFToken.sol";

contract NFTMarketplace is NFToken {

    event Transfer(address indexed buyer, address indexed seller, uint tokenId, uint256 amount);
    event Register(address indexed seller, uint tokenId, string tokenUri, uint256 amount);

    address owner;
    mapping(uint256 => uint256) currentPrice;
    CardToken public ftAddress;

    constructor (address _ftAddress) 
    NFToken("NFToken", "NFT") {
        ftAddress = CardToken(_ftAddress);
        owner = msg.sender;
    }

    
    function getCurrentPrice(uint256 _tokenId) public view returns (uint256) {
        require(_exists(_tokenId));
        return currentPrice[_tokenId];
    }

    
    function setCurrentPrice(uint256 _tokenId, uint256 _amount) public {
        require(_exists(_tokenId));
        require(msg.sender != address(0) && msg.sender == ownerOf(_tokenId));
        require(_amount > 0);
        currentPrice[_tokenId] = _amount;
    }

    
    function purchaseNFT(uint256 _tokenId, uint256 _amount) public {
        require(msg.sender != address(0) && msg.sender != address(this));
        require(_amount >= ftAddress.balanceOf(msg.sender));
        require(_exists(_tokenId));
        require(_amount >= currentPrice[_tokenId]);
        address tokenSeller = ownerOf(_tokenId);
        ftAddress.transfer(owner,_amount);
        safeTransferFrom(tokenSeller, msg.sender, _tokenId);
        emit Transfer(msg.sender, tokenSeller, _tokenId, _amount);
    }

    
    function generateNFT(uint256 _tokenId, string memory _tokenUri, uint256 _price) public {
        require(msg.sender != address(0) && msg.sender != address(this));
        require(_price > 0);
        require(!_exists(_tokenId));
        mintUniqueTokenTo(msg.sender, _tokenId, _tokenUri);
        setCurrentPrice(_tokenId, _price);
        emit Register(msg.sender, _tokenId, _tokenUri, _price);
    }
}
