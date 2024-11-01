const { ethers } = require('hardhat')

async function main() {
  const unimart = await ethers.deployContract('UnimartPayment');

  await unimart.waitForDeployment();

  console.log('Unimart Contract Deployed at ' + unimart.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});