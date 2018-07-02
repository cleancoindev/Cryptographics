const AssetManager = artifacts.require("../contracts/AssetManager.sol");


const utils = require("../front/scripts/utils.js");


contract('AssetManager', async(accounts) => {
    let assetManagerContract;

    before(async () => {
        assetManagerContract = await AssetManager.deployed();
    });


    it("... should create an asset", async () => {
        let ipfsHash = "0x1234567";
        let price = 500;

        await assetManagerContract.createAsset(ipfsHash, price,  {from: accounts[0]});

        let numberOfAssets = await assetManagerContract.getNumberOfAssets();

        assert.equal(numberOfAssets, 1, "There'd be only 1 asset");
    });



    it("... user should have  permission for asset", async() => {
        let ipfsHash = "0x12345678";
        let price = 500000000000000;


        await assetManagerContract.createAsset(ipfsHash, price, {from: accounts[0]});

        let permission = await assetManagerContract.checkHasPermission(accounts[0], 0);
        assert.equal(permission, true, "User had to have permission for this asset")
    });

    it("... user should be owner of asset pack", async() => {
          let ipfsHashes = [ 'QmUJeMmc2jETHdTUfCQyK27bMhSfoAFfRpQuX5RpVN2gHf',
                'QmQKJdkbGEsiav3vdzK8pTH5WoNXCoXN8VbZLrFoWjmPwR',
                'Qmd9VNGsVST4y4ZLz5rQtLMxDb2HhJwutAfQ5Et5MoAA7z',
                'QmaL8YXHZA2aayApzaAeeV7RDJXAf5ZvqCbPraQkgdkTSh',
                'QmPNSue3FwTVeYsYrDtMBPWWofFQCtP72C3m8vtYS3xEAu'];

          for (let i=0; i<ipfsHashes.length; i++){
               ipfsHashes[i] = utils.getBytes32FromIpfsHash(ipfsHashes[i]);
          }

          await assetManagerContract.createAssetPack(ipfsHashes,500000);

          let userPacks = await assetManagerContract.getAssetPacksUserCreated(accounts[0]);

          assert.equal(userPacks, 0, "Should be owner of 0th asset pack");
    });

    it("... user should be owner of all assets inside pack", async() => {
        let ipfsHashes = [ 'QmUJeMMc2jETHdTUfCQyK27bMhSfoAFfRpQuX5RpVN2gHf',
            'QmQKJdkbGEsiav3vdzK8PTH5WoNXCoXN8VbZLrFoWjmPwR',
            'Qmd9VNGsVST4y4ZLz5rQLLMxDb2HhJwutAfQ5Et5MoAA7z',
            'QmaL8YXHZA2aayApzaAeVV7RDJXAf5ZvqCbPraQkgdkTSh',
            'QmPNSue3FwTVeYsYrDtBBPWWofFQCtP72C3m8vtYS3xEAu'];

        for (let i=0; i<ipfsHashes.length; i++){
            ipfsHashes[i] = utils.getBytes32FromIpfsHash(ipfsHashes[i]);
        }

        await assetManagerContract.createAssetPack(ipfsHashes,500000);

        let packData = await assetManagerContract.getAssetPackData(0);
        console.log(packData);
    });


});