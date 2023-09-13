# jki.tcl

# This script is currently in 'DELTA' stage, meaning it is possible it could halt, fault, or break your bot. 

## Basic Information
This script is ran and tested with [eggdrop](http://eggheads.org) 1.8.4

Currently requires no extra packages, but will require sqlite3 when published for use.

Parts of this script are inspired by [speechles 'fourtwenty' script](https://github.com/speechles/eggdrop/blob/master/tcl/fourtwenty.tcl) on GitHub :)

Other parts of this script are brainstormed and tested on [IRC-Nerds](https://webchat.irc-nerds.net/) with wez, nitecore, Monopoly, and prototrip

## Install
to install, clone it to your scripts/ folder, then find jki-settings.tcl and edit to your liking.

## Public channel commands
These commands are used in a channel that the bot is on.

The command character is defined by settings->gen->pubtrig

 Command      | Function
--------------|----------
pack          | tells the bot to prepare the channel for a "chan-wide toke-out"
junky         | use and O.D. on substances
weed          | smoke or pass various types of devices
pass          | pass a randomly selected device around the channel
bong          | load and pass a bong around the channel
pipe          | load and pass a pipe around the channel
joint         | roll and pass a joint around the channel
dealer        | buy stock for your junkies to use
register      | register with the bot to become a dealer

## Drug settings
This script allows you to select various was to control what content goes where. There are 3 secondary channel flags and 1 primary.

 Channel Flag  | Function
---------------|----------
 jnki          | Primary flag, most functions require this
 weed          | Weed-related interactions require this
 sch3          | Soft substances unlocked with this
 sch2          | Mild substances unlocked with this
 sch1          | Hard substances unlocked with this

## Contact
I can be contacted at irc.irc-nerds.net in #fuknz, #bots, and #nerds
