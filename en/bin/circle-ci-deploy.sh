#!/bin/bash

echo "Where am I?"
pwd
echo "What's here?"
ls
echo "What's the config?"
set | grep CIRCLE

exit 1
