// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

import "./Credits.sol";
import "./Disposals.sol";
import "./Materials.sol";
import "./Products.sol";
import "./Proposals.sol";
import "./Stakeholders.sol";

contract DAO_PoC {
  // CONTRACTS =======================
  Credits CCredits = new Credits();
  Disposals CDisposals = new Disposals();
  Materials CMaterials = new Materials();
  Products CProducts = new Products();
  Proposals CProposals = new Proposals();
  Stakeholders CStakeholders = new Stakeholders();

  // STRUCTS =========================
  struct Material {
    bool is_toxic;
    string name;
    uint16 weight_mg;
  }

  // STATE VARIABLES =================
  Material[] public product_materials;
  uint32 public amount_of_disposed_devices;
  uint32 public collector_id;
  uint32 public consumer_id;
  uint32 public manufacturer_id;
  uint32 public product_id;
  uint32 public proposal_id;
  uint32 public recycler_id;
  uint64 public disposed_device_id;

  // FUNCTIONS =======================
  function run() public {
    // 1. Registration of stakeholders
    collector_id = CStakeholders.addStakeholder("COLLECTOR", 0x123456789abcdef0);
    consumer_id = CStakeholders.addStakeholder("CONSUMER", 0x123456789abcdef0);
    manufacturer_id = CStakeholders.addStakeholder("MANUFACTURER", 0x123456789abcdef0);
    recycler_id = CStakeholders.addStakeholder("RECYCLING CENTER", 0x123456789abcdef0);

    // 2. Manufacturer registers a product and its composition
    product_id = CProducts.addProduct(manufacturer_id, "Smartphone Model X", "SKU-1");

    CMaterials.addMaterialOf(product_id, false, "Copper", 60);
    CMaterials.addMaterialOf(product_id, false, "Silver", 15);

    // 3. Recycling center announces the disposal of the residue
    disposed_device_id = CDisposals.dispose(
      0x123456789abcdef0,
      collector_id,
      consumer_id,
      manufacturer_id,
      product_id,
      recycler_id
    );

    // 4. Computing credits for involved stakeholders
    CCredits.giveCreditTo(collector_id, 80);
    CCredits.giveCreditTo(consumer_id, 20);
    CCredits.giveCreditTo(manufacturer_id, 40);
    CCredits.giveCreditTo(recycler_id, 60);

    // 5. Observer queries the amount of discarded residues and the constitution of discarded e-waste
    amount_of_disposed_devices = CDisposals.getQuantityOf(product_id);

    uint32[] memory material_ids = CMaterials.getMaterialsOf(product_id);
    for (uint32 i = 0; i < material_ids.length; i++) {
      (bool is_toxic, string memory name, uint16 weight_mg) = CMaterials.getMaterial(material_ids[i]);
      product_materials.push(Material(is_toxic, name, weight_mg));
    }

    // 6. Collector creates a proposal for recycling the disposed product
    proposal_id = CProposals.createProposal(recycler_id, "Encourage metal collection with a 5% increase in credits received for 3 months.");

    // 7. Stakeholders vote on the recycling proposal
    CProposals.voteOnProposal(proposal_id, collector_id, true);
    CProposals.voteOnProposal(proposal_id, consumer_id, false);
    CProposals.voteOnProposal(proposal_id, manufacturer_id, true);
    CProposals.voteOnProposal(proposal_id, recycler_id, true);
  }
}
