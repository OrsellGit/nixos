#!/usr/bin/env bash

BAT=$(ls /sys/class/power_supply |grep BAT |head -n 1)
get_perc () {
  #capacity="$(${pkgs.coreutils}/cat /sys/class/power_supply/${BAT}/capacity)"
  capacity="$(cat /sys/class/power_supply/${BAT}/capacity)"
  echo ${capacity}

  #BATSTATUS="$(${pkgs.coreutils}/cat /sys/class/power_supply/${BAT}/status)"
  BATSTATUS="$(cat /sys/class/power_supply/${BAT}/status)"
  echo ${BATSTATUS}

  #CURRENTWATTAGE="$(${pkgs.coreutils}/cat /sys/class/power_supply/${BAT}/current_now /sys/class/power_supply/${BAT}/voltage_now | xargs | awk '{printf "%.1f", $1*$2/1e12}')"
  CURRENTWATTAGE="$(cat /sys/class/power_supply/${BAT}/current_now /sys/class/power_supply/${BAT}/voltage_now | xargs | awk '{printf "%.1f", $1*$2/1e12}')"
  echo ${CURRENTWATTAGE}

}

main () {
  get_perc
  if [ "$BATSTATUS" == "Discharging" ]; then
    if [ "$capacity" -le 20 ]; then
      notify-send "Battery Warning!" "Battery is at ${capacity}% discharging at a rate of ${CURRENTWATTAGE}W!"
    else
      #echo "Battery is at ${capacity}%"
      notify-send "Battery is at ${capacity}%\nUsing ${CURRENTWATTAGE}W."
      #echo "Using $(cat /sys/class/power_supply/${BAT}/current_now /sys/class/power_supply/${BAT}/voltage_now | xargs | awk '{printf "%.1fW.", $1*$2/1e12}')"
      #notify-send "Using "
    fi
  fi
}

main