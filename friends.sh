#!/bin/bash

friends=(Kyle Marc Jem "Paul Tobin" Sarah) # define an array

echo My second friend is ${friends[1]} # access an element in the array

for friend in ${friends[*]}
do
    echo friend: $friend
done

echo "I have ${#friends[*]} friends"
