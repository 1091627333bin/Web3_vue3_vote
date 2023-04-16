

const Contacts = artifacts.require("Vote.sol")

module.exports = function(deployer){
    deployer.deploy(Contacts,['张锐彬','肖颖巧'])
}