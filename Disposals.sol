// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

contract Disposals {
  // STRUCTS =========================
  struct Disposal {
    bytes8 device_uuid;
    uint32 collector_id;
    uint32 consumer_id;
    uint32 manufacturer_id;
    uint32 product_id;
    uint32 recycler_id;
  }

  // STATE VARIABLES =================
  mapping(bytes8 => Disposal) disposals; // device code -> disposal record
  mapping(uint32 => uint32) quantities; // product id -> amount disposed

  // EVENTS ==========================
  event OnDispose(bytes8 device_uuid, uint32 product_id);

  // FUNCTIONS =======================
  function dispose(
    bytes8 _device_uuid,
    uint32 _collector_id,
    uint32 _consumer_id,
    uint32 _manufacturer_id,
    uint32 _product_id,
    uint32 _recycler_id
  ) public returns (uint64) {
    disposals[_device_uuid] = Disposal(
      _device_uuid,
      _collector_id,
      _consumer_id,
      _manufacturer_id,
      _product_id,
      _recycler_id
    );
    // add disposal to the respective product quantity
    quantities[_product_id] += 1;
    // emit event about disposal
    emit OnDispose(_device_uuid, _product_id);
    // return _device_uuid in numeric form
    return (uint64(_device_uuid));
  }

  function getQuantityOf(
    uint32 _product_id
  ) public view returns (uint32) {
    return (quantities[_product_id]);
  }
}
