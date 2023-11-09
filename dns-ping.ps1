# check a network's hosts and write to a csv
# i will use the csv to generate a diagram
Param(
	[Parameter(Mandatory, Position=0)]
	[string]$Prefix,
	[Parameter(Mandatory, Position=1)]
	[string]$File
)
$n = 1
#csv format:
#name,ip,type,connect
#hostname,1.1.1.1,router,
#hostname,8.8.8.8,host,1.1.1.1

# loop assuming /24
while($n -lt 255) {
	$ip = "$Prefix.$n"
	$response = Resolve-DnsName -QuickTimeout -Type PTR -Name "$ip"
	$hostname = $response.NameHost
	if ($response.Type -Match "PTR") {
		echo "$ip = $hostname"
		# so draw.io can use a different style
		if ($n -eq 1) {
			$type = "router"
			$connect = ""
		} else {
			# tell draw.io to make the router the host's parent
			$type = "host"
			$connect = "$Prefix.1"
		}
		# if it responds to a ping fast, count it as up
		ping -n 1 -w 2 "$ip"
		if ($?) {
			echo "$hostname,$ip,$type,$connect" >> $File
		}
	}
	else {
		echo "$ip has no PTR record"
	}
	$n++
}