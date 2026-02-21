// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

contract Proposals {
  // STRUCTS =========================
  struct Proposal {
    uint32 proposal_id;
    uint32 proposer_id;
    uint256 created_at;
    string theme;
    uint32 agree;
    uint32 disagree;
    bool active;
  }

  // STATE VARIABLES =================
  uint32 index = 1; // proposal id counter
  mapping(uint32 => Proposal) proposals;
  mapping(uint32 => mapping(uint32 => bool)) votes; // proposal_id => stakeholder_id => has_voted

  // EVENTS ==========================
  event OnProposalCreated(uint32 proposal_id, string theme, uint32 proposer_id);
  event OnVote(uint32 proposal_id, uint32 stakeholder_id, bool vote);

  // FUNCTIONS =======================
  function createProposal(
    uint32 _stakeholder_id,
    string calldata _theme
  ) public returns (uint32) {
    require(_stakeholder_id > 0 && _stakeholder_id < index, "Invalid stakeholder");

    uint32 proposal_id = index;
    Proposal storage newProposal = proposals[proposal_id];
    newProposal.proposal_id = proposal_id;
    newProposal.theme = _theme;
    newProposal.proposer_id = _stakeholder_id;
    newProposal.created_at = block.timestamp;
    newProposal.active = true;
    index++;

    emit OnProposalCreated(proposal_id, _theme, _stakeholder_id);

    return proposal_id;
  }

  function voteOnProposal(
    uint32 _proposalId,
    uint32 _stakeholder_id,
    bool _vote
  ) public {
    require(_proposalId > 0 && _proposalId < index, "Non-existent proposal");
    require(_stakeholder_id > 0 && _stakeholder_id < index, "Invalid stakeholder");

    Proposal storage proposal = proposals[_proposalId];
    require(proposal.active, "Proposal is not active");
    require(!votes[_proposalId][_stakeholder_id], "Vote already counted");

    votes[_proposalId][_stakeholder_id] = true;

    if (_vote) {
      proposal.agree++;
    } else {
      proposal.disagree++;
    }

    emit OnVote(_proposalId, _stakeholder_id, _vote);
  }
}