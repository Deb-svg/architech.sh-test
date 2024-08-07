#!/bin/bash

update_sys() {
  echo "Progessing..."
  sleep 2
  sudo apt-get update
  echo "Wait for upgrade"
  sleep 1
  sudo apt-get upgrade -y
}

install_packages() {
  local packages=("$@")
  echo "Installing packages: ${packages[@]}"
  sleep 4
  sudo apt-get install -y "${packages[@]}"
}

configure_wifi() {
  local ssid="$1"
  local password="$2"
  echo "Configuring Wi-Fi with SSID: $ssid"

  adb shell "am start -n com.android.settings/.wifi.WifiSettings"
  adb shell "input keyevent 61"
  adb shell "input text '$ssid'"
  adb shell "input keyevent 61"
  adb shell "input text '$password'"
  adb shell "input keyevent 66"
}

install_apk() {
  local apk_path="$1"
  echo "Installing APK: $apk_path"
  adb install "$apk_path"
  
}

set_brightness() {
  local level="$1"
  echo "Setting brightness level to $level"
  adb shell "settings put system screen_brightness $level"
}

configure_firewall() {
  echo "Configuring firewall..."
  sudo ufw enable
  sudo ufw allow ssh
  sudo ufw allow http
  sudo ufw allow https
  sudo ufw status
}

setup_docker() {
  echo "setting up Docker..."
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker $USER
}

set_bash_prompt() {
  local prompt="$1"
  echo "Setting custom bash prompt..."
  echo "PS1='$prompt '" >> ~/.bashrc
  source ~/.bashrc
}

customize_smartphone() {
  echo "Customizing smartphone..."
  update_sys()

  local smartphone_packages=("adb" "fastboot" "scrcpy")
  install_packages("${smartphone_packages[@]}")

  echo "Enabling Developer Options and USB Debugging..."
  adb shell "settings put global development_settings_enabled 1"
  adb shell "settings put global adb_enabled 1"

  configure_wifi("YourWI-FINetwork" "YourWI-FIPassword")

  install_apk("/path/to/app1.apk")
  install_apk("/path/to/app2.apk")

  set_brightness(200)

  echo "Smartphone customization completed!"
}

customize_computer() {
  echo "Customizing computer..."
  update_sys()

  local computer_packages=("curl" "vim" "git" "htop" "code" "docker-ce" "docker-ce-cli" "containerd.io")
  install_packages "${computer_packages[@]}"

  configure_firewall()

  setup_docker()

  set_bash_prompt("Archx86")

  echo "Computer customization completed!"
}
