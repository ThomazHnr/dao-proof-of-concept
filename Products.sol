// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

contract Products {
  // STRUCTS =========================
  struct Product {
    uint32 product_id;
    uint32 manufacturer_id;
    string model;
    string sku;
  }

  // STATE VARIABLES =================
  uint32 index = 1; // index starts at 1 to facilitate testing
  mapping(uint32 => Product) products; // index -> Product

  // EVENTS ==========================
  event OnAddProduct(uint32 manufacturer_id, string model);

  // FUNCTIONS =======================
  function addProduct(
    uint32 _manufacturer_id,
    string calldata _model,
    string calldata _sku
  ) public returns (uint32) {
    // add product to products
    products[index] = Product(index, _manufacturer_id, _model, _sku);
    // add register in the quantities
    index++;
    emit OnAddProduct(_manufacturer_id, _model);
    return (index - 1);
  }
}
