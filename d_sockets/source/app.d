import std.stdio;
import std.socket;

struct Data{
	int x;
	int y;
	int z;
}

auto toBytes( Data )( ref Data data ){
	return cast(ubyte[])(&data)[0..1];
}
auto fromBytes(Data)( ubyte[] bytes ){
	return *cast(Data*)bytes;
}

void main(){
		
	Data d = {10,20,30};
	writeln("(s)erver or (c)lient ? ");
	auto type = readln()[0];
	if( type == 's' ){


		auto socket = new UdpSocket();
		auto address = new InternetAddress( "localhost", 666 );
		socket.bind( address );

		writeln("UDPSocket Up!");
		while(true){
			Address from_address;
			ubyte[1024] buffer;
			socket.receiveFrom( buffer, from_address );

	        writefln("    IP address: %s", from_address.toAddrString());
	        writefln("    Hostname: %s", from_address.toHostNameString());
	        writefln("    Port: %s", from_address.toPortString());
	        writefln("    Service name: %s",from_address.toServiceNameString());
	        writefln("    Data:");
	        writeln( fromBytes!Data(buffer) );

		}
	}
	else{

		
		auto socket = new UdpSocket();
		auto address = new InternetAddress( "localhost", 666 );
		ubyte[] buffer = cast(ubyte[])"Hello World";

		writeln("Sending...");
		writeln(d);
		socket.sendTo(d.toBytes!Data, address );

	}

}
