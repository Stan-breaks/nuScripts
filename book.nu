#!/usr/bin/env nu
def main [] {
    cd ~/books
    let books = (ls | where name =~ '\.pdf$' | get name)
    mut menu = ""

    for f in $books {
        let tmpimg = ("/tmp/" + ($f | path basename | str replace '.pdf' ''))
        if (not ($"($tmpimg).png" | path exists)) {
           ^pdftoppm -png -singlefile $f $tmpimg
        }
        $menu = $menu + ($"($f)(char nul)icon(char us)thumbnail://($tmpimg).png(char nl)")
    }

    let choice = $menu | rofi -dmenu -show-icons 

    if $choice != "" {
       ^zathura $choice
    }
}

