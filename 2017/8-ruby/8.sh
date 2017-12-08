#!/bin/bash
(
    echo "reg=Hash.new(0)" ;
    (cat input |
         perl -pe 's/dec (-?\d+)/inc -\1/ ;
                   s/inc (-*\d+)/+= \1/;
                   s/^(\w+)/reg["\1"]/;
                   s/if (\w+)/if reg["\1"]/'
    );
    echo "puts reg.values.max"
) | ruby
