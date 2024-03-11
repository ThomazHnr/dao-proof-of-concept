// SPDX-License-Identifier: LICENSED

pragma solidity 0.8.19;

import "./Stakeholders.sol";
import "./Products.sol";
import "./Materials.sol";
import "./Disposals.sol";
import "./Credits.sol";

contract ProofOfConcept {
  // CONTRACTS =======================
  Stakeholders CStakeholders = new Stakeholders();
  Products CProducts = new Products();
  Materials CMaterials = new Materials();
  Disposals CDisposals = new Disposals();
  Credits CCredits = new Credits();

  // STRUCTS =========================
  struct Material {
    bool is_toxic;
    string name;
    uint16 weight_mg;
  }

  // STATE VARIABLES =================
  uint32 public manufacturer_id;
  uint32 public recycler_id;
  uint32 public product_id;
  uint64 public disposed_device_id;
  uint16 public amount_of_credits;
  uint32 public amount_of_disposed_devices;
  Material[] public product_materials;

  // FUNCTIONS =======================
  function run() public {
    // 1. register a manufacturer : 
    manufacturer_id = CStakeholders.addStakeholder("MANUFACTURER", 0x248571eb9273144d);

    // 2. register a recycling center : 
    recycler_id = CStakeholders.addStakeholder("RECYCLING CENTER", 0x8ed911dd9f814a6f);

    // 3. register a product : 
    product_id = CProducts.addProduct(manufacturer_id, "Smartphone Model X", "SKU 1");

    // 4. register a product's materials : 
    CMaterials.addMaterialOf(product_id, false, "Copper", 10);

    // 5. announcement of the disposal of the registered product : 
    disposed_device_id = CDisposals.dispose(0xb1e9e923035f9390, product_id, recycler_id, manufacturer_id, 1);

    // 6. give credits : 
    CCredits.giveCreditTo(manufacturer_id, 10);
    amount_of_credits = CCredits.getCreditOf(manufacturer_id);

    // 7. query discarded amount of a product : 
    amount_of_disposed_devices = CDisposals.getQuantityOf(product_id);

    // 8. query product materials : 
    uint32[] memory material_ids = CMaterials.getMaterialsOf(product_id);
    for (uint32 i = 0; i < material_ids.length; i++) {
      (bool is_toxic, string memory name, uint16 weight_mg) = CMaterials.getMaterial(material_ids[i]);
      product_materials.push(Material(is_toxic, name, weight_mg));
    }
  }
}
