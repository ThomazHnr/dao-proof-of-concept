// SPDX-License-Identifier: LICENSED

pragma solidity 0.8.19;

contract Disposals {
  // STRUCTS =========================
  struct Disposal {
    bytes8 device_code;
    uint32 product_id;
    uint32 recipient_id;
    uint32 sender_id;
    uint32 timestamp;
  }

  // STATE VARIABLES =================
  mapping(bytes8 => Disposal) disposals; // device code -> disposal record
  mapping(uint32 => uint32) quantities; // product id -> amount disposed

  // EVENTS ==========================
  event OnDispose(bytes8 device_code, uint32 product_id);

  // FUNCTIONS =======================
  function dispose(
    bytes8 _device_code,
    uint32 _product_id,
    uint32 _recipient_id,
    uint32 _sender_id,
    uint32 _timestamp
  ) public returns (uint64) {
    disposals[_device_code] = Disposal(_device_code, _product_id, _recipient_id, _sender_id, _timestamp);
    // add disposal to the respective product quantity
    quantities[_product_id] += 1;
    // emit event about disposal
    emit OnDispose(_device_code, _product_id);
    // return _device_code in numeric form
    return (uint64(_device_code));
  }

  function getQuantityOf(
    uint32 _product_id
  ) public view returns (uint32) {
    return (quantities[_product_id]);
  }
}
