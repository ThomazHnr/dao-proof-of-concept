// SPDX-License-Identifier: LICENSED

pragma solidity 0.8.19;

contract Stakeholders {
  // STRUCTS =========================
  struct Stakeholder {
    uint32 stakeholder_id;
    string role;
    bytes8 access_token;
  }

  // STATE VARIABLES =================
  uint32 index = 1; // index starts at 1 to facilitate testing
  mapping(uint32 => Stakeholder) stakeholders;

  // EVENTS ==========================
  event OnAddStakeholder(uint32 stakeholder_id, string role);

  // FUNCTIONS =======================
  function addStakeholder(
    string calldata _role,
    bytes8 _access_token
  ) public returns (uint32) {
    stakeholders[index] = Stakeholder(index, _role, _access_token);
    index++;
    emit OnAddStakeholder(index - 1, _role);
    return (index - 1);
  }
}
