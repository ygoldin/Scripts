#!/bin/bash

screen -d | grep "(Detached)" > screens.txt
while read p; do
  num=${p/.*/}
  screen -X -S "$num" quit
done < screens.txt
rm screens.txt
