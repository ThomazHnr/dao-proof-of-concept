// SPDX-License-Identifier: UNLICENSED

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
  uint32 public consumer_id;
  uint32 public collector_id;
  uint32 public recycler_id;
  uint32 public product_id;
  uint64 public disposed_device_id;
  uint32 public amount_of_disposed_devices;
  Material[] public product_materials;

  // FUNCTIONS =======================
  function run() public {
    // 1. Registration of stakeholders
    manufacturer_id = CStakeholders.addStakeholder("MANUFACTURER", 0x123456789abcdef0);
    consumer_id = CStakeholders.addStakeholder("CONSUMER", 0x123456789abcdef0);
    collector_id = CStakeholders.addStakeholder("COLLECTOR", 0x123456789abcdef0);
    recycler_id = CStakeholders.addStakeholder("RECYCLING CENTER", 0x123456789abcdef0);

    // 2. Manufacturer registers a product
    product_id = CProducts.addProduct(manufacturer_id, "Smartphone Model X", "SKU-1");

    // 3. Manufacturer registers the raw materials constituting the product
    CMaterials.addMaterialOf(product_id, false, "Copper", 60);
    CMaterials.addMaterialOf(product_id, false, "Silver", 15);

    // Steps 4 to 6 don't have interactions with the DAO's smart contracts

    // 7. Recycling center announces the disposal of the residue
    disposed_device_id = CDisposals.dispose(
      0x123456789abcdef0,
      collector_id,
      consumer_id,
      manufacturer_id,
      product_id,
      recycler_id
    );

    // 6. Computing credits for involved stakeholders
    CCredits.giveCreditTo(manufacturer_id, 100);
    CCredits.giveCreditTo(consumer_id, 100);
    CCredits.giveCreditTo(collector_id, 100);
    CCredits.giveCreditTo(recycler_id, 100);

    // 7. Observer queries the amount of discarded residues
    amount_of_disposed_devices = CDisposals.getQuantityOf(product_id);

    // 8. Observer queries the constitution of discarded e-waste
    uint32[] memory material_ids = CMaterials.getMaterialsOf(product_id);
    for (uint32 i = 0; i < material_ids.length; i++) {
      (bool is_toxic, string memory name, uint16 weight_mg) = CMaterials.getMaterial(material_ids[i]);
      product_materials.push(Material(is_toxic, name, weight_mg));
    }
  }
}
