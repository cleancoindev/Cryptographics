---
id: Image_DigitalPrintImage
title: DigitalPrintImage
---

<div class="contract-doc"><div class="contract"><h2 class="contract-header"><span class="contract-kind">contract</span> DigitalPrintImage</h2><p class="base-contracts"><span>is</span> <a href="Image_ImageToken.html">ImageToken</a></p><div class="source">Source: <a href="git+https://github.com/DecenterApps/DigitalPrint/blob/v1.0.0/contracts/Image/DigitalPrintImage.sol" target="_blank">Image/DigitalPrintImage.sol</a></div></div><div class="index"><h2>Index</h2><ul><li><a href="Image_DigitalPrintImage.html#addAssetManager">addAssetManager</a></li><li><a href="Image_DigitalPrintImage.html#addFunctionsContract">addFunctionsContract</a></li><li><a href="Image_DigitalPrintImage.html#createImage">createImage</a></li></ul></div><div class="reference"><h2>Reference</h2><div class="functions"><h3>Functions</h3><ul><li><div class="item function"><span id="addAssetManager" class="anchor-marker"></span><h4 class="name">addAssetManager</h4><div class="body"><code class="signature">function <strong>addAssetManager</strong><span>(address _assetManager) </span><span>public </span></code><hr/><div class="description"><p>During testing can be changed, after deployment to main network can be set only once, Function to add assetManager.</p></div><dl><dt><span class="label-modifiers">Modifiers:</span></dt><dd><a href="Utils_Ownable.html#onlyOwner">onlyOwner </a></dd><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_assetManager</code> - is address of assetManager contract</div></dd></dl></div></div></li><li><div class="item function"><span id="addFunctionsContract" class="anchor-marker"></span><h4 class="name">addFunctionsContract</h4><div class="body"><code class="signature">function <strong>addFunctionsContract</strong><span>(address _functionsContract) </span><span>public </span></code><hr/><div class="description"><p>During testing can be changed, after deployment to main network can be set only once, Function to add functions contract.</p></div><dl><dt><span class="label-modifiers">Modifiers:</span></dt><dd><a href="Utils_Ownable.html#onlyOwner">onlyOwner </a></dd><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_functionsContract</code> - is address of Functions contract</div></dd></dl></div></div></li><li><div class="item function"><span id="createImage" class="anchor-marker"></span><h4 class="name">createImage</h4><div class="body"><code class="signature">function <strong>createImage</strong><span>(uint[] _randomHashIds, uint _timestamp, uint _iterations, bytes32[] _potentialAssets, string _author) </span><span>public </span><span>payable </span><span>returns  (uint) </span></code><hr/><div class="description"><p>_txHash and _timestamp together with keccak256 will give us randomSeed for user, Function will create new image.</p></div><dl><dt><span class="label-parameters">Parameters:</span></dt><dd><div><code>_randomHashIds</code> - is array of random hashes from our array</div><div><code>_timestamp</code> - is timestamp when image is created</div><div><code>_iterations</code> - is number of how many times he generated random asset positions until he liked what he got</div><div><code>_potentialAssets</code> - is set of all potential assets user selected for an image</div><div><code>_author</code> - is nickname of image owner</div></dd><dt><span class="label-return">Returns:</span></dt><dd>returns id of created image</dd></dl></div></div></li></ul></div></div></div>