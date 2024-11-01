// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnimartPayment {
    address payable public admin;  // Contract owner
    uint public platformFee = 5;   // 5% platform fee

    event PaymentInitialized(address indexed user, uint amount, address[] vendors);
    event PaymentProcessed(address indexed vendor, uint amount);

    constructor() {
        admin = payable(msg.sender);
    }
          
    struct Vendor {
        address payable wallet;
        uint256 amount;
    }

    function getBalance(address _address) public view returns (uint256) {
        return _address.balance;
    }

    function initializePayment(Vendor[] memory vendors) public payable {
        uint amount = msg.value;
        uint platformCut = (amount * platformFee) / 100;
        require(amount > platformCut, "Insufficient amount to cover platform fees");

        for (uint i = 0; i < vendors.length; i++) {
            uint vendorAmount = vendors[i].amount - platformCut;
            vendors[i].wallet.transfer(vendorAmount);
            emit PaymentProcessed(vendors[i].wallet, vendorAmount);
        }

        // Transfer platform fee to admin
        admin.transfer(platformCut);
        emit PaymentInitialized(msg.sender, amount, getVendorAddresses(vendors));
    }

    function getVendorAddresses(Vendor[] memory vendors) internal pure returns (address[] memory) {
        address[] memory addresses = new address[](vendors.length);
        for (uint i = 0; i < vendors.length; i++) {
            addresses[i] = vendors[i].wallet;
        }
        return addresses;
    }
}
