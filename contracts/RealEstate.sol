// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Import OpenZeppelin libraries
import "@openzeppelin/contracts/utils/Counters.sol"; // For safely incrementing token IDs
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // Base ERC721 NFT contract
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // ERC721 extension to store tokenURI metadata

// Define our contract, inheriting ERC721URIStorage
contract RealEstate is ERC721URIStorage {
    
    // Use Counters library to manage token IDs safely
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; // Counter to keep track of NFT IDs

    // Constructor runs once when contract is deployed
    // Initializes ERC721 with a name and symbol
    constructor() ERC721("Real Estate", "Real") {
        // "Real Estate" = name of the NFT collection
        // "Real" = symbol of the NFT collection
    }

    /**
     * @dev Mint a new NFT
     * @param tokenURI The link to the metadata JSON describing the NFT
     * @return The ID of the newly minted NFT
     */
    function mint(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment(); // Increase token ID counter
        uint256 newItemId = _tokenIds.current(); // Get the new token ID
        
        _mint(msg.sender, newItemId); // Mint NFT to the caller's wallet
        _setTokenURI(newItemId, tokenURI); // Attach metadata (image, description, etc.) to the NFT
        
        return newItemId; // Return new NFT ID
    }

    /**
     * @dev Get total number of NFTs minted
     * @return The current total supply of NFTs
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current(); // Return how many NFTs have been created
    }
}
