#!/usr/bin/env nu
def main [] {
    display /home/Stanbreaks/books
}

def display [filePath: string ] {
    let books = (ls --short-names $filePath | get name)
    mut menu = ""
    for f in $books {
        if ($f =~ '.pdf') {
           let tmpimg = ("/tmp/" + ($f | path basename | str replace '.pdf' ''))
           print $tmpimg
           if (not ($"($tmpimg).png" | path exists)) {
              ^pdftoppm -png -singlefile ($"($filePath)/($f)") $tmpimg
           }
           $menu = $menu + ($"($f)(char nul)icon(char us)thumbnail://($tmpimg).png(char nl)")
        } else {
           $menu = $menu + ($"($f)(char nl)")
        }
    }

    let choice = $menu | rofi -dmenu -show-icons 

    echo $choice
    if $choice != "" {
      if $choice =~ '.pdf' {
         ^zathura ($"($filePath)/($choice)")
      } else {
        display ($"($filePath)/($choice)")
      }
    }
}

