#!/usr/bin/bash

## Declare a function

sample() {
  echo Hello , I am a Sample function
  echo Value of a = ${a}
  b=200
}

## Main Program

## Call the function
a=100
sample
echo Value of b = ${b}
