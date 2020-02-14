#!/bin/bash -eu
killall conky
conky -c /home/$USER/.config/conky/informant/inf-paper.conkyrc

