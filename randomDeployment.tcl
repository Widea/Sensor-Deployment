puts "************************************************************"

puts "\n\nDEPLOYMENT OF SENSORS -> REGULAR DEPLOYMENT (SQUARE)"

puts "************************************************************" 

#Create a simulator object
set ns [new Simulator]

# open the trace file
set tracefile1 [open random.tr w]
$ns trace-all $tracefile1

#open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile

#s1, s2, s3 and s4 act as sources.
set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set s4 [$ns node]

set s5 [$ns node]
set s6 [$ns node]
set s7 [$ns node]
set s8 [$ns node]

set s9 [$ns node]
set s10 [$ns node]
set s11 [$ns node]
set s12 [$ns node]

#G acts as a gateway.
set G1 [$ns node]
set G2 [$ns node]
set G3 [$ns node]

#r acts as a receiver.
set r1 [$ns node]
#set r2 [$ns node]
#set r3 [$ns node]

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

$ns duplex-link $s5 $G2 6Mb 10ms DropTail
$ns duplex-link $s6 $G2 6Mb 10ms DropTail
$ns duplex-link $s7 $G2 6Mb 10ms DropTail
$ns duplex-link $s8 $G2 6Mb 10ms DropTail
$ns duplex-link $G2 $r1 3Mb 30ms DropTail

$ns duplex-link $s9 $G3 6Mb 10ms DropTail
$ns duplex-link $s10 $G3 6Mb 10ms DropTail
$ns duplex-link $s11 $G3 6Mb 10ms DropTail
$ns duplex-link $s12 $G3 6Mb 10ms DropTail
$ns duplex-link $G3 $r1 3Mb 30ms DropTail


#Define the queue size for the link between node G and r
#$ns queue-limit $G $r 5

#Define the layout of the topology
$ns duplex-link-op $s1 $G1 orient right-up
$ns duplex-link-op $s2 $G1 orient right-down
$ns duplex-link-op $s3 $G1 orient left-up
$ns duplex-link-op $s4 $G1 orient left-down
$ns duplex-link-op $G1 $r1 orient left

$ns duplex-link-op $s5 $G2 orient right-up
$ns duplex-link-op $s6 $G2 orient right-down
$ns duplex-link-op $s7 $G2 orient left-up
$ns duplex-link-op $s8 $G2 orient left-down
$ns duplex-link-op $G2 $r1 orient left


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

#Create a TCP agent and attach it to node s5
set tcp5 [new Agent/TCP/Reno]
$ns attach-agent $s5 $tcp5
$tcp1 set window_ 8
$tcp1 set fid_ 1

#Create a TCP agent and attach it to node s6
set tcp6 [new Agent/TCP/Reno]
$ns attach-agent $s6 $tcp6
$tcp2 set window_ 8
$tcp2 set fid_ 2

#Create a TCP agent and attach it to node s7
set tcp7 [new Agent/TCP/Reno]
$ns attach-agent $s7 $tcp7
$tcp3 set window_ 4
$tcp3 set fid_ 3

#Create a TCP agent and attach it to node s8
set tcp8 [new Agent/TCP/Reno]
$ns attach-agent $s8 $tcp8
$tcp3 set window_ 4
$tcp3 set fid_ 4


#Create a TCP agent and attach it to node s9
set tcp9 [new Agent/TCP/Reno]
$ns attach-agent $s9 $tcp9
$tcp1 set window_ 8
$tcp1 set fid_ 1

#Create a TCP agent and attach it to node s10
set tcp10 [new Agent/TCP/Reno]
$ns attach-agent $s10 $tcp10
$tcp2 set window_ 8
$tcp2 set fid_ 2

#Create a TCP agent and attach it to node s11
set tcp11 [new Agent/TCP/Reno]
$ns attach-agent $s11 $tcp11
$tcp3 set window_ 4
$tcp3 set fid_ 3

#Create a TCP agent and attach it to node s12
set tcp12 [new Agent/TCP/Reno]
$ns attach-agent $s12 $tcp12
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

#Create TCP sink agents and attach them to node r
set sink5 [new Agent/TCPSink]
set sink6 [new Agent/TCPSink]
set sink7 [new Agent/TCPSink]
set sink8 [new Agent/TCPSink]

$ns attach-agent $r1 $sink5
$ns attach-agent $r1 $sink6
$ns attach-agent $r1 $sink7
$ns attach-agent $r1 $sink8

#Connect the traffic sources with the traffic sinks
$ns connect $tcp5 $sink5
$ns connect $tcp6 $sink6
$ns connect $tcp7 $sink7
$ns connect $tcp8 $sink8

#Create TCP sink agents and attach them to node r
set sink9 [new Agent/TCPSink]
set sink10 [new Agent/TCPSink]
set sink11 [new Agent/TCPSink]
set sink12 [new Agent/TCPSink]

$ns attach-agent $r1 $sink9
$ns attach-agent $r1 $sink10
$ns attach-agent $r1 $sink11
$ns attach-agent $r1 $sink12

#Connect the traffic sources with the traffic sinks
$ns connect $tcp9 $sink9
$ns connect $tcp10 $sink10
$ns connect $tcp11 $sink11
$ns connect $tcp12 $sink12

#Create FTP applications and attach them to agents
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4


set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5

set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp6

set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp7

set ftp8 [new Application/FTP]
$ftp8 attach-agent $tcp8


set ftp9 [new Application/FTP]
$ftp9 attach-agent $tcp9

set ftp10 [new Application/FTP]
$ftp10 attach-agent $tcp10

set ftp11 [new Application/FTP]
$ftp11 attach-agent $tcp11

set ftp12 [new Application/FTP]
$ftp12 attach-agent $tcp12


$ns at 0.0 "$s1 label Sensor1"
$ns at 0.0 "$s2 label Sensor2"
$ns at 0.0 "$s3 label Sensor3"
$ns at 0.0 "$s4 label Sensor4"
$ns at 0.0 "$G1 label Gateway1"
$ns at 0.0 "$s5 label Sensor5"
$ns at 0.0 "$s6 label Sensor6"
$ns at 0.0 "$s7 label Sensor7"
$ns at 0.0 "$s8 label Sensor8"
$ns at 0.0 "$G2 label Gateway2"
$ns at 0.0 "$s9 label Sensor9"
$ns at 0.0 "$s10 label Sensor10"
$ns at 0.0 "$s11 label Sensor11"
$ns at 0.0 "$s12 label Sensor12"
$ns at 0.0 "$G3 label Gateway3"
$ns at 0.0 "$r1 label BaseStation"
$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp2 start"
$ns at 0.2 "$ftp3 start"
$ns at 0.2 "$ftp4 start"
$ns at 0.1 "$ftp5 start"
$ns at 0.3 "$ftp6 start"
$ns at 0.2 "$ftp7 start"
$ns at 0.2 "$ftp8 start"
$ns at 0.1 "$ftp9 start"
$ns at 0.3 "$ftp10 start"
$ns at 0.2 "$ftp11 start"
$ns at 0.4 "$ftp12 start"
$ns at 5.0 "$ftp1 stop"
$ns at 5.0 "$ftp2 stop"
$ns at 5.0 "$ftp3 stop"
$ns at 5.0 "$ftp4 stop"
$ns at 5.0 "$ftp5 stop"
$ns at 5.0 "$ftp6 stop"
$ns at 5.0 "$ftp7 stop"
$ns at 5.0 "$ftp8 stop"
$ns at 5.0 "$ftp9 stop"
$ns at 5.0 "$ftp10 stop"
$ns at 5.0 "$ftp11 stop"
$ns at 5.0 "$ftp12 stop"
$ns at 5.25 "finish"

$ns run
