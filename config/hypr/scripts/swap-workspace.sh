#!/usr/bin/sh

hyprctl dispatch hyprexpo:expo toggle
sleep 0.26
hyprctl dispatch workspace "$([ -n "$1" ] && printf "e-1" || printf "e+1")"
