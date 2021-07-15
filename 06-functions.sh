#!/usr/bin/bash

## Declare a function

sample() {
  echo Hello , I am a Sample function
  echo Value of a = ${a}
}

## Call the function
a=100
sample
