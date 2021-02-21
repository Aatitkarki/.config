#!/bin/bash
WHEREAMI=$(cat ${HOME}/.cwd)
echo $WHEREAMI
kitty --directory="$WHEREAMI"
