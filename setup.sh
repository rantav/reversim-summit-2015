#!/bin/bash

echo
echo "Checking for existing componenents and installing on demand..."
echo "=============================================================="
echo
which meteor || curl https://install.meteor.com | /bin/sh

echo
echo DONE
echo