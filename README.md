# net-diagram
I used this to generate parts of a network diagram somewhere.
It uses draw.io & PowerShell. Not polished, but I'll share anyway.
There aren't many details, just the hostname and IP address.

## Caveats
- You may dislike the layout. The entire thing is more specific to the network I was looking at &
  I did 90% of the diagram manually already.
- It only makes a distinction between a host/node and a router.
- The script is quite limited.
  * Only scans an entire /24
  * Relies on reverse DNS, maybe your LAN does not have it.
  * It only writes to the CSV if the host can respond to a ping in 20ms.

## Usage
1. Run the PowerShell script. It will create a CSV with a filename of your choice.
2. Make a new diagram in draw.io, then combine the config file and your new CSV.
3. Add `waterway;` to the style of each router manually. For some reason, I cannot get draw.io to do this.
4. It still looks awful! Burn your computer.
