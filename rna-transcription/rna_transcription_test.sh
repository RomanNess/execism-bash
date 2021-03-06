#!/usr/bin/env bash

@test "no parameters prints usage" {
  run bash rna_transcription.sh
  [ "$status" -eq 1 ]
  [ "$output" == "Usage: rna_transcription.sh <dna-strand>" ]
}

@test "too many parameters prints usage" {
  run bash rna_transcription.sh ACGT TGCA
  [ "$status" -eq 1 ]
  [ "$output" == "Usage: rna_transcription.sh <dna-strand>" ]
}

@test "Empty RNA sequence" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh ""
  [ "$status" -eq 0 ]
  [ "$output" == "" ]
}

@test "RNA complement of cytosine is guanine" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh C
  [ "$status" -eq 0 ]
  [ "$output" == "G" ]
}

@test "RNA complement of guanine is cytosine" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh G
  [ "$status" -eq 0 ]
  [ "$output" == "C" ]
}

@test "RNA complement of thymine is adenine" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh T
  [ "$status" -eq 0 ]
  [ "$output" == "A" ]
}

@test "RNA complement of adenine is uracil" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh A
  [ "$status" -eq 0 ]
  [ "$output" == "U" ]
}

@test "RNA complement" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh ACGTGGTCTTAA
  [ "$status" -eq 0 ]
  [ "$output" == "UGCACCAGAAUU" ]
}

@test "Handles invalid character" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh ACGTXCTTA
  [ "$status" -eq 1 ]
  [ "$output" == "Invalid nucleotide detected." ]
}

@test "Handles completely invalid string" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh XXXX
  [ "$status" -eq 1 ]
  [ "$output" == "Invalid nucleotide detected." ]
}

@test "Handles partially invalid string" {
  # [[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash rna_transcription.sh ACGTXCTTAA
  [ "$status" -eq 1 ]
  [ "$output" == "Invalid nucleotide detected." ]
}

