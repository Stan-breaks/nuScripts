#!/usr/bin/env nu

let output = [[City Time];[Nairobi (date now| format date '%H:%M' | into string)]]
let output = $output ++ [[City Time];[Ottawa ((date now | date to-timezone Canada/Eastern |format date '%H:%M') | into string)]]

$output 
