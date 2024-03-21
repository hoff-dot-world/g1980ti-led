# g1980ti-led
This repository is intended as both documentation and a source of tools that are a result of my reverse engineering efforts on the LED control system of the Gigabyte G1 980 Ti GAMING 6GB, or model number GV-N98TG1 GAMING-6GD.


![](demo.gif)

### Information about the Reverse Engineering Process
The final product (shell script) looks incredibly simple, but the reverse engineering process is where the real magic and work happened. Documentation on this process is available in the docs/ folder of this repository in a LaTeX-compiled PDF format, with more to be added soon.

## Introduction

### Rationale of this Project:
The software used to control Gigabyte's Maxwell generation cards (pre-Aorus) is known as OC Guru II. This is the only known piece of software able to change lighting on the G1 980 Ti. It has been replaced by new Aorus software which is able to control new cards, but lacks backwards compatibility. OC Guru II is not particularly good software nor is it getting updates anymore, so having that on your system would be undesirable. It also is Windows-only, and as a full-time Linux user these days it'd be cool if I could control the lights from my OS of choice.

### Current State - Gigabyte G1 980 Ti LED Colour Control is possible on Linux!
The project has gotten to the point where changing the LED colours in Linux is possible with a shell script. You can choose from all the colours you normally would be able to in OC Guru II: Blue, Red, Green, Yellow, Magenta, Cyan and White.

Lighting effects and brightness are currently being investigated with a little help from the OpenRGB project. They're cool guys, go check them out; it's a project I researched extensively while doing my own reversing of this card. Eventually I hope to get support for this card implemented into OpenRGB based on the legwork I've done reversing it.

### A Quck word of Warning
I am not responsible for what you do to your card. I know it's a bit of a joke for developers to say this, but it really "works on my machine" and I haven't been able to test it anywhere else, so YMMV. Keep in mind I only have one card to test it on. I doubt the manufacturing process would be different for other cards of this model (in fact if it was it'd be a little odd) but use the tools provided in this repo at your own risk. They are provided with no warranty or assurances whatsoever. From what I've seen though, the LED controller gets reset after a shutdown so that usually fixes anything for me when I've sent bad commands during testing.

### Installation and Usage
The colour changing script and other tools found in this repository depend on i2c-tools. Please install it or its equivalent from your package manager.
Before running the script,

#### Compatibility Check
I recommend you verify a few things about your card in particular. As I cannot test with multiple cards, only one, we need to make sure that your card has the same properties as mine. To test this, please run these commands after installing i2c-tools:
```bash
$ sudo modprobe i2c-dev
$ i2cdetect -r 2
```
Enter Y at the prompt. If the only value in the table that's returned is 48, then go ahead and run the script and hopefully your colours will change too. If not, please open an issue so I can do my best to assist you.

#### Arguments and Usage
You can clone the repository or download the script directly, mark it as executable and then run it. It takes these possible arguments:

| Argument | Effect                           |
|----------|----------------------------------|
| blue     | Sets colour to a dark blue       |
| red      | Sets colour to red               |
| green    | Sets colour to green             |
| yellow   | Sets colour to yellow            |
| magenta  | Sets colour to a purple/magenta  |
| cyan     | Sets colour to a light blue/cyan |
| white    | Sets colour to white             |
| off      | Turn the LEDs Off                |

Usage:
```bash
$ chmod +x /path/to/g1980ti-led.sh
$ /path/to/g1980ti-led.sh argument
```
An example use case you might give is this:
```bash
$ ~/src/scripts/g1980ti-led.sh magenta
```
Executes the script if stored in ~/src/scripts and sets the colour of the LED to magenta.

Pro Tip: Consider setting a bash alias to the script so you don't have to type the path.

UPDATE: So I've added a new script, this one emulates the "Colour Cycle" of OC Guru II but in a more useful way. The way OC Guru did it was sending a colour change request to the LED controller every once and a while. Haven't timed it so don't know the exact details. But this additional script emulates that but allows the user to set the interval as an argument. The argument is a number in seconds before the next colour will be selected randomly.

![](demo-random.gif)

#### Troubleshooting
Didn't work for you, but you passed the compatibility check? Try running it a few more times, sometimes the card's LED controller needs data written to it multiple times before it activates. If this fails, open an issue and I'll give you a hand.
