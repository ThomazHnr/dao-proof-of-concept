// SPDX-License-Identifier: LICENSED

pragma solidity 0.8.19;

contract Credits {
  // STATE VARIABLES =================
  mapping(uint32 => uint16) credits; // stakeholder's id -> credit amount

  // EVENTS ==========================
  event OnGiveCredit(uint32 stakeholder_id, uint16 amount);

  // FUNCTIONS =======================
  function getCreditOf(
    uint32 _stakeholder_id
  ) public view returns (uint16) {
    return (credits[_stakeholder_id]);
  }

  function giveCreditTo(
    uint32 _beneficiary_id,
    uint8 _amount
  ) public {
    credits[_beneficiary_id] += _amount;
    emit OnGiveCredit(_beneficiary_id, _amount);
  }
}
