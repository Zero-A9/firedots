use std::process::Command;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    // Set environment variables
    std::env::set_var("DISPLAY", ":0");
    std::env::set_var("DBUS_SESSION_BUS_ADDRESS", "unix:path=/run/user/1000/bus");

    // Battery battery_level at which to notify
    let warning_level = 29;

    // Get battery information
    let output = Command::new("upower")
        .arg("-i")
        .arg("/org/freedesktop/UPower/devices/battery_BAT0")
        .output()
        .expect("Failed to execute command");
    let output_string = String::from_utf8_lossy(&output.stdout);

    let status = output_string
        .lines()
        .find(|line| line.contains("state"))
        .unwrap()
        .split_whitespace()
        .nth(1)
        .unwrap();
    let battery_discharging = status.contains("discharging");
    
    //Get battery level of charged
    let battery_path = "/sys/class/power_supply/BAT0/capacity";
    let file = File::open(battery_path).unwrap();
    let reader = BufReader::new(file);
    let mut battery_level = String::new();
    for line in reader.lines() {
        battery_level = line.unwrap();
        break;
    }
    let battery_level = battery_level.trim().parse::<i32>().unwrap();

    // Use two files to store whether we've shown a notification or not (to prevent multiple notifications)
    let empty_file = "/tmp/batteryempty";
    let full_file = "/tmp/batteryfull";

    // Reset notifications if the computer is charging/discharging
    if battery_discharging && std::path::Path::new(full_file).exists() {
        std::fs::remove_file(full_file).unwrap();
    } else if !battery_discharging && std::path::Path::new(empty_file).exists() {
        std::fs::remove_file(empty_file).unwrap();
    }

    // If the battery is charging and is full (and has not shown notification yet)
    if battery_level > 95 && !battery_discharging && !std::path::Path::new(full_file).exists() {
        let _ = Command::new("notify-send")
            .arg("Battery Charged")
            .arg("Battery is fully charged.")
            .arg("-i")
            .arg("battery-full-charged")
            .spawn()
            .expect("Failed to execute command");
        let _output = Command::new("aplay")
            .arg("/home/ahmed/Downloads/output3.wav")
            .output()
            .expect("failed to play sound file");

        std::fs::File::create(full_file).unwrap();
    }
    // If the battery is low and is not charging (and has not shown notification yet)
    else if battery_level <= warning_level && battery_discharging && !std::path::Path::new(empty_file).exists() {
        let _ = Command::new("notify-send")
            .arg("low battery")
            .arg(format!("{}% of battery remaining.", battery_level))
            .arg("-u")
            .arg("critical")
            .arg("-i")
            .arg("battery-empty")
            .spawn()
            .expect("failed to execute command");

        let _output = Command::new("aplay")
            .arg("/home/ahmed/Downloads/output.wav")
            .output()
            .expect("failed to play sound file");

        std::fs::File::create(empty_file).unwrap();
    }
}


