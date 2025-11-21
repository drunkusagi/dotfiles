#!/usr/bin/sh

hyprctl dispatch hyprexpo:expo toggle || true
sleep 0.30
hyprctl dispatch workspace "$([ -n "$1" ] && printf "e-1" || printf "e+1")"
