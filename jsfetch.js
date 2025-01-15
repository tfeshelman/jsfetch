///////////////////////////////////////////////////////
//                ___       __           __          //
//  __          /'___\     /\ \__       /\ \         //
// /\_\    ____/\ \__/   __\ \ ,_\   ___\ \ \___     //
// \/\ \  /',__\ \ ,__\/'__`\ \ \/  /'___\ \  _ `\   //
//  \ \ \/\__, `\ \ \_/\  __/\ \ \_/\ \__/\ \ \ \ \  //
//  _\ \ \/\____/\ \_\\ \____\\ \__\ \____\\ \_\ \_\ //
// /\ \_\ \/___/  \/_/ \/____/ \/__/\/____/ \/_/\/_/ //
// \ \____/                                          //
//  \/___/                                           //
//                     Just in case we needed another//
///////////////////////////////////////////////////////


// Pull in required library
const os = require('os');
const fs = require('fs');

////////////////////
// Memory Section //
////////////////////

// Retrieve total memory
let totMem = os.totalmem();
let outTotMem;

// Retrieve free memory
let freeMem = os.freemem()

// Vars for the inverse
let usedMem;
let outUsedMem;

// Selects display size based on total memory (gb vs mb)
if (totMem >= 1000000000) {

    // Truncates to single decimal point
    totMem = Math.round(totMem/100000000) / 10;
    outTotMem = totMem + "gb";

    freeMem = Math.round(freeMem/100000000) / 10;

    // Finds used memory, truncates to one decimal point
    usedMem = Math.round((totMem - freeMem) * 10) / 10;
    outUsedMem = usedMem + "gb"

} else if (totalMem >= 1000000 && totalMem < 1000000000) {
    totMem = Math.round(totMem/100000) / 10;
    outTotMem = totMem + "mb";

    freeMem = Math.round(freeMem/100000) / 10;

    usedMem = Math.round((totMem - freeMem) * 10) / 10;
    outUsedMem = usedMem + "mb"

} else {
    outTotMem = totMem + " bytes"
    outUsedMem = (totMem - freeMem) + " bytes"
}

/////////////////
// CPU Section //
/////////////////

// Retrieve full info block, then break it up
let cpuInfo = os.cpus();
let cpuCores = cpuInfo.length;
let cpuModel = cpuInfo[0].model;

let cpuSpeed = cpuInfo[0].speed;
if (cpuSpeed >= 1000) { cpuSpeed = (Math.round(cpuSpeed/10) / 100) + "ghz"; } else { cpuSpeed = cpuSpeed + "mhz"; }

////////////////////////
// System Examination //
////////////////////////

// Open OS file, read it, split each line apart (regex code for return)
let readOS = fs.readFileSync('/etc/os-release', 'utf-8').split(/\r?\n/)
let distro;

// Sort through each line until the correct line is found
for (let i in readOS) {
    if (readOS[i].indexOf("PRETTY_NAME=") >= 0) {
        distro = readOS[i].slice(readOS[i].indexOf('"')+1, -1);
        break;
    }
}

if (distro.includes.toLowerCase("ubuntu")) {
    if (fs.existsSync("/usr/share/libkubuntu")) {
        distro = "K" + distro;
    }
    else if (fs.existsSync("/usr/share/xubuntu")) {
        distro = "X" + distro;
    }
    else if (fs.existsSync("/usr/share/lubuntu")) {
        distro = "L" + distro;
    }
    else { distro = distro; }
}


////////////
// Uptime //
////////////

let upTimeInit = os.uptime();

let upTimeHour = Math.trunc((Math.trunc(upTimeInit) / 3600));
let upTimeMin = Math.trunc(Math.trunc(Math.trunc(upTimeInit) % 3600) / 60);
let upTimeSec = Math.trunc(upTimeInit) % 60;



/////////////
// Outputs //
/////////////

console.log(`\x1b[35m%s\x1b[34m%s`, `       ___   `, `.------.`)

// Host
console.log(`\x1b[35m%s\x1b[34m%s\x1b[33m%s`, `     _/___|_ `, `|  `, `host|   ${os.hostname().toLocaleLowerCase()}`);

// Distro
console.log(`\x1b[34m%s\x1b[37m%s\x1b[34m%s\x1b[32m%s`, `      (`, `.`, ` _)  |    `, `os|   ${distro.toLowerCase()}`);

// Kernel
console.log(`\x1b[34m%s\x1b[0m`, `  .^^^/  /   |kernel|   ${os.release().toLowerCase()}`)

// CPU
console.log(`\x1b[34m%s\x1b[35m%s`, ` //   \\\_/\\   |   `, `cpu|   ${cpuModel.toLowerCase()} (x${cpuCores}) @ ${cpuSpeed}`);

// Memory
console.log(`\x1b[34m%s\x1b[36m%s`, `((________)  |`, `memory|   ${outUsedMem} / ${outTotMem} (${(Math.trunc((usedMem/totMem)*100))}%)`);

// Uptime
console.log(`\x1b[34m%s\x1b[37m%s`, `||_|   ||_|  |`, `uptime|   ${upTimeHour}h, ${upTimeMin}m, ${upTimeSec}s`);

console.log(`\x1b[32m%s\x1b[34m%s\x1b[0m`, `^^^^^^^^^^^`, `  '------'`);


//////////////////////
// Colors reference //
//////////////////////

// Reset = "\x1b[0m"
// Bright = "\x1b[1m"
// Dim = "\x1b[2m"
// Underscore = "\x1b[4m"
// Blink = "\x1b[5m"
// Reverse = "\x1b[7m"
// Hidden = "\x1b[8m"

// FgBlack = "\x1b[30m"
// FgRed = "\x1b[31m"
// FgGreen = "\x1b[32m"
// FgYellow = "\x1b[33m"
// FgBlue = "\x1b[34m"
// FgMagenta = "\x1b[35m"
// FgCyan = "\x1b[36m"
// FgWhite = "\x1b[37m"
// FgGray = "\x1b[90m"

// BgBlack = "\x1b[40m"
// BgRed = "\x1b[41m"
// BgGreen = "\x1b[42m"
// BgYellow = "\x1b[43m"
// BgBlue = "\x1b[44m"
// BgMagenta = "\x1b[45m"
// BgCyan = "\x1b[46m"
// BgWhite = "\x1b[47m"
// BgGray = "\x1b[100m"
