
pragma solidity >=0.7.0 <0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFToken is ERC721 {
    constructor (
        string memory _name, 
        string memory _symbol
        ) ERC721(_name, _symbol)
    { }

    function mintUniqueTokenTo(
        address _to,
        uint256 _tokenId,
        string memory _tokenURI
    ) public
    {
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);
    }
}
