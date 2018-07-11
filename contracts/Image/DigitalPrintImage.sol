pragma solidity ^0.4.23;

import "./ImageToken.sol";
import "../Utils/Functions.sol";
import "../IAssetManager.sol";


contract DigitalPrintImage is ImageToken, Functions {

    struct ImageMetadata {
        uint randomSeed;
        uint iterations;
        bytes32[] potentialAssets;
        uint timestamp;
        string author;
        address owner;
        string ipfsHash;
    }


    mapping(uint => bool) seedExists;
    mapping(uint => ImageMetadata) public imageMetadata;
    mapping(uint => string) public idToIpfsHash;

    address public marketplaceContract;
    IAssetManager assetManager;


    modifier onlyMarketplaceContract() {
        require(msg.sender == address(marketplaceContract));
        _;
    }

    /// @dev only for testing purposes
    // function createImageTest() public returns(uint) {
    //     return createImage(msg.sender);
    // }

    /// @notice Function will create new image
    /// @dev owner of image will be msg.sender, and timestamp will be automatically generated, timestamp will be automatically generated
    /// @dev _txHash and _timestamp together with keccak256 will give us randomSeed for user
    /// @param _randomHashIds is array of random hashes from our array
    /// @param _timestamp is timestamp when image is created
    /// @param _iterations is number of how many times he generated random asset positions until he liked what he got
    /// @param _potentialAssets is set of all potential assets user selected for an image
    /// @param _author is nickname of image owner
    /// @param _ipfsHash is ipfsHash of the image .png
    /// @return returns id of created image
    function createImage(uint[] _randomHashIds, uint _timestamp, uint _iterations, bytes32[]  _potentialAssets, string _author, string _ipfsHash) public payable returns (uint) {
        require(_potentialAssets.length <= 5);

        uint randomSeed = calculateSeed(_randomHashIds, _timestamp);
        uint finalSeed = uint(getFinalSeed(randomSeed, _iterations));

        require(seedExists[finalSeed] == false);

        uint[] memory pickedAssets;

        (pickedAssets,,) = pickRandomAssets(randomSeed,_iterations, _potentialAssets);
        address _owner = msg.sender;

        uint[] memory pickedAssetPacks = assetManager.pickUniquePacks(pickedAssets);

        uint finalPrice = calculatePrice(pickedAssetPacks, _owner);
        require(msg.value >= finalPrice);

        for(uint i=0; i<pickedAssetPacks.length ;i++) {
            if(assetManager.checkHasPermissionForPack(_owner, pickedAssetPacks[i]) == false){
                assetManager.givePermission(msg.sender, pickedAssetPacks[i]);
            }
        }

        uint id = createImage(_owner);

        imageMetadata[id] = ImageMetadata({
            randomSeed: randomSeed,
            iterations: _iterations,
            potentialAssets: _potentialAssets,
            timestamp: _timestamp,
            author: _author,
            owner: _owner,
            ipfsHash: _ipfsHash
        });

        idToIpfsHash[id] = _ipfsHash;
        seedExists[finalSeed] = true;
        return id;
    }

    /// @notice Function to calculate final price for an image based on selected assets
    /// @param _pickedAssets is array of picked packs
    /// @param _owner is address of image owner
    /// @return finalPrice for the image
    function calculatePrice(uint[] _pickedAssets, address _owner) public view returns (uint) {
        if(_pickedAssets.length == 0) {
            return 0;
        }

        uint[] memory pickedAssetPacks = assetManager.pickUniquePacks(_pickedAssets);
        uint finalPrice = 0;
        for(uint i=0; i<pickedAssetPacks.length; i++) {
            if(assetManager.checkHasPermissionForPack(_owner, pickedAssetPacks[i]) == false) {
                finalPrice += assetManager.getAssetPackPrice(pickedAssetPacks[i]);
            }
        }

        return finalPrice;
    }



    function getImageMetadata(uint _imageId) public view returns(uint, uint, bytes32[], uint, string, address, string) {
        require(_imageId < numOfImages);

        ImageMetadata memory metadata = imageMetadata[_imageId];

        return(metadata.randomSeed, metadata.iterations, metadata.potentialAssets, metadata.timestamp, metadata.author, metadata.owner, metadata.ipfsHash);

    }



    /// @notice adds marketplace address to contract only if it doesn't already exist
    /// @param _marketplaceContract address of marketplace contract
    function addMarketplaceContract(address _marketplaceContract) public onlyOwner {
        // not required while on testnet
        // @dev require(address(marketplaceContract) == 0x0);
        marketplaceContract = _marketplaceContract;
    }


    /// @notice approving image to be taken from specific address
    /// @param _to address that we give permission to take image
    /// @param _imageId we are willing to give
    function transferFromMarketplace(address _from, address _to, uint256 _imageId) public onlyMarketplaceContract {
        require(tokensForOwner[_imageId] != 0x0);
        require(ownerOf(_imageId) == _from);

        tokensForApproved[_imageId] = 0x0;
        removeImage(_from, _imageId);
        addImage(_to, _imageId);

        emit Approval(_from, 0, _imageId);
        emit Transfer(_from, _to, _imageId);
    }


    /// @notice Function to add assetManager
    /// @dev during testing can be changed, after deployment to main network can be set only once
    /// @param _assetManager is address of assetManager contract
    function addAssetManager(address _assetManager) public onlyOwner {
        assetManager = IAssetManager(_assetManager);
    }

}