#!/usr/bin/env bash

cur=$(brightnessctl g)
max=$(brightnessctl m)

printf "{\"percentage\":%d}" $((cur * 100 / max))
