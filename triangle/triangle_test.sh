#!/usr/bin/env bash

# Test returns true if the triangle is equilateral

@test "true if all sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 2 2 2
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "false if any side is unequal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 2 3 2
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "false if no sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 5 4 6
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "All zero sides are illegal, so the triangle is not equilateral" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 0 0 0
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "All zero sides are illegal, so the triangle is not equilateral (with floats)" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 0.0 0.00 0.000
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

# Bonus: deal with floats

@test "sides may be floats" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 0.5 0.5 0.5
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "sides may be floats with different precision" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh equilateral 0.5 0.50 0.500
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

# Test returns true if the triangle is isosceles

@test "true if last two sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 3 4 4
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "true if first two sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 4 4 3
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "true if first and last sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 4 3 4
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "equilateral triangles are also isosceles" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 4 4 4
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "false if no sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 2 3 4
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "Sides that violate triangle inequality are not isosceles, even if two are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 1 1 3
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "Sides that violate triangle inequality are not isosceles, even if two are equal (with floats)" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 1 1.0 3.00
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

# Bonus: deal with floats

@test "sides may be floats" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 0.5 0.4 0.5
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "sides may be floats with different precision" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh isosceles 0.5 0.40 0.500
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

# Test returns true if the triangle is scalene

@test "true if no sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 5 4 6
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "false if all sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 4 4 4
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "false if two sides are equal" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 4 4 3
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "Sides that violate triangle inequality are not scalene, even if they are all different" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 7 3 2
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

@test "Sides that violate triangle inequality are not scalene, even if they are all different (with floats)" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 7 3.0 2.00
  [ "$status" -eq 0 ]
  [ "$output" == "false" ]
}

# Bonus: deal with floats

@test "sides may be floats" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 0.5 0.4 0.6
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "sides may be floats with different precision" {
  #[[ $BATS_RUN_SKIPPED == true  ]] || skip
  run bash triangle.sh scalene 0.5 0.40 0.600
  [ "$status" -eq 0 ]
  [ "$output" == "true" ]
}

@test "print usage on wrong mode" {
  run bash triangle.sh unknwon 1 1 1
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: triangle.sh <scalene|equilateral|isosceles> <triangle-side> <triangle-side> <triangle-side>" ]
}

@test "print usage on to few params" {
  run bash triangle.sh scalene 1 1
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: triangle.sh <scalene|equilateral|isosceles> <triangle-side> <triangle-side> <triangle-side>" ]
}

@test "print usage on to many params" {
  run bash triangle.sh scalene 1 1 1 1
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: triangle.sh <scalene|equilateral|isosceles> <triangle-side> <triangle-side> <triangle-side>" ]
}
