// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

contract Materials {
  // STRUCTS =========================
  struct Material {
    uint32 material_id;
    bool is_toxic;
    string name;
    uint16 weight_mg;
  }

  // STATE VARIABLES =================
  uint32 index = 1; // index starts at 1 to facilitate testing
  mapping(uint32 => Material) materials; // index -> Material
  mapping(uint32 => uint32[]) materials_of; // product id -> index[]

  // EVENTS ==========================
  event OnAddMaterial(uint32 product_id, string name, uint16 weight_mg);

  // FUNCTIONS =======================
  function addMaterialOf(
    uint32 _product_id,
    bool _is_toxic,
    string calldata _name,
    uint16 _weight_mg
  ) public returns (uint32) {
    materials[index] = Material(index, _is_toxic, _name, _weight_mg);
    materials_of[_product_id].push(index);
    index++;
    emit OnAddMaterial(_product_id, _name, _weight_mg);
    return (index - 1);
  }

  function getMaterial(
    uint32 _material_id
  ) public view returns (bool, string memory, uint16) {
    bool is_toxic = materials[_material_id].is_toxic;
    string memory name = materials[_material_id].name;
    uint16 weight_mg = materials[_material_id].weight_mg;
    return (is_toxic, name, weight_mg);
  }

  function getMaterialsOf(
    uint32 _product_id
  ) public view returns (uint32[] memory) {
    return (materials_of[_product_id]);
  }
}
