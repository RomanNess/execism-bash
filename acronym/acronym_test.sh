#!/usr/bin/env bash

@test 'basic' {
  #skip
  run bash acronym.sh 'Portable Network Graphics'
  [ "$status" -eq 0 ]
  [ "$output" == 'PNG' ]
}

@test 'lowercase words' {
  #skip
  run bash acronym.sh 'Ruby on Rails'
  [ "$status" -eq 0 ]
  [ "$output" == 'ROR' ]
}

@test 'punctuation' {
  #skip
  run bash acronym.sh 'First In, First Out'
  [ "$status" -eq 0 ]
  [ "$output" == 'FIFO' ]
}

@test 'all caps word' {
  #skip
  run bash acronym.sh 'GNU Image Manipulation Program'
  [ "$status" -eq 0 ]
  [ "$output" == 'GIMP' ]
}

@test 'punctuation without whitespace' {
  #skip
  run bash acronym.sh 'Complementary metal-oxide semiconductor'
  [ "$status" -eq 0 ]
  [ "$output" == 'CMOS' ]
}

@test 'very long abbreviation' {
  #skip
  run bash acronym.sh 'Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me'
  [ "$status" -eq 0 ]
  [ "$output" == 'ROTFLSHTMDCOALM' ]
}

@test 'no argument shows usage' {

  run bash acronym.sh
  [ "$status" -eq 1 ]
  [ "$output" == "Usage: acronym.sh <string>" ]
}

@test 'to many arguments shows usage' {

  run bash acronym.sh 'Oh' 'my' 'god'
  [ "$status" -eq 1 ]
  [ "$output" == "Usage: acronym.sh <string>" ]
}