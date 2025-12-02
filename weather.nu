#!/usr/bin/env nu
def main [] {
  let cache_file = $"($env.HOME)/.cache/nu-weather-cache.json"
  let cities = ["Ottawa","Nairobi"]

  let cache_valid = if ($cache_file | path exists ) {
    ls $cache_file | get modified | first | (date now) - $in | $in < 1hr
  } else {
    touch $cache_file
    false
  }
  let weather_data = if $cache_valid {
    open $cache_file
  } else {
    let data = $cities | par-each {|city|{
      city : $city
      weather: (http get $"https://wttr.in/($city)?format=3")     
    }
   }
    $data | to json | save --force $cache_file
    $data
  }
  $weather_data
}

