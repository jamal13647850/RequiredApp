#!/bin/bash

colors(){
    for fg_color in {0..9}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..9}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done
}

setColors(){
    local foreground=$1
    local background=$2
    set_foreground=$(tput setaf $foreground)
    set_background=$(tput setab $background)
    echo -n $set_background$set_foreground
}


echoTitle(){
    local foreground=$1
    local background=$2
    local text=$3
    setColors $1 $2
    echo -e ". . . . . . . . . . . . . . . . . . . $3 . . . . . . . . . . . . . . . . . . . . . . . . ."
    setColors 15 16
}

