puts "************************************************************"

puts "\n\nDEPLOYMENT OF SENSORS -> REGULAR DEPLOYMENT (SQUARE)"

puts "************************************************************" 

#Create a simulator object
set ns [new Simulator]

# open the trace file
set tracefile1 [open square.tr w]
$ns trace-all $tracefile1

#open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

#s1, s2, s3 and s4 act as sources.
set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set s4 [$ns node]

#G acts as a gateway.
set G1 [$ns node]


#r acts as a receiver.
set r1 [$ns node]


#Define different colors for data flows
$ns color 1 red ; #the color of packets from s1
$ns color 2 blue; #the color of packets from s2
$ns color 3 yellow; #the color of packets from s3
$ns color 4 green; #the color of packets from s4 

#Create links between the nodes
$ns duplex-link $s1 $G1 6Mb 10ms DropTail
$ns duplex-link $s2 $G1 6Mb 10ms DropTail
$ns duplex-link $s3 $G1 6Mb 10ms DropTail
$ns duplex-link $s4 $G1 6Mb 10ms DropTail
$ns duplex-link $G1 $r1 3Mb 30ms DropTail

#Define the queue size for the link between node G and r
#$ns queue-limit $G $r 5

#Define the layout of the topology
$ns duplex-link-op $s1 $G1 orient right-up
$ns duplex-link-op $s2 $G1 orient right-down
$ns duplex-link-op $s3 $G1 orient left-up
$ns duplex-link-op $s4 $G1 orient left-down
$ns duplex-link-op $G1 $r1 orient left

#define a "finish" procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	puts "running nam..."
	exec nam out.nam &
	exit 0
}


#Create a TCP agent and attach it to node s1
set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $s1 $tcp1
$tcp1 set window_ 8
$tcp1 set fid_ 1

#Create a TCP agent and attach it to node s2
set tcp2 [new Agent/TCP/Reno]
$ns attach-agent $s2 $tcp2
$tcp2 set window_ 8
$tcp2 set fid_ 2

#Create a TCP agent and attach it to node s3
set tcp3 [new Agent/TCP/Reno]
$ns attach-agent $s3 $tcp3
$tcp3 set window_ 4
$tcp3 set fid_ 3

#Create a TCP agent and attach it to node s3
set tcp4 [new Agent/TCP/Reno]
$ns attach-agent $s4 $tcp4
$tcp3 set window_ 4
$tcp3 set fid_ 4

#Create TCP sink agents and attach them to node r
set sink1 [new Agent/TCPSink]
set sink2 [new Agent/TCPSink]
set sink3 [new Agent/TCPSink]
set sink4 [new Agent/TCPSink]

$ns attach-agent $r1 $sink1
$ns attach-agent $r1 $sink2
$ns attach-agent $r1 $sink3
$ns attach-agent $r1 $sink4

#Connect the traffic sources with the traffic sinks
$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2
$ns connect $tcp3 $sink3
$ns connect $tcp4 $sink4

#Create FTP applications and attach them to agents
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4

$ns at 0.0 "$s1 label Sensor1"
$ns at 0.0 "$s2 label Sensor2"
$ns at 0.0 "$s3 label Sensor3"
$ns at 0.0 "$s4 label Sensor4"
$ns at 0.0 "$G1 label Gateway"
$ns at 0.0 "$r1 label BaseStation"
$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp2 start"
$ns at 0.1 "$ftp3 start"
$ns at 0.1 "$ftp4 start"
$ns at 5.0 "$ftp1 stop"
$ns at 5.0 "$ftp2 stop"
$ns at 5.0 "$ftp3 stop"
$ns at 5.0 "$ftp4 stop"
$ns at 5.25 "finish"

$ns run
