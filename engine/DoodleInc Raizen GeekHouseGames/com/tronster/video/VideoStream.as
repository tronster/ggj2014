/**
The MIT License

Copyright (c) 2013, Tronster, http://tronster.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

@author Tronster of Geek House Games, http://geekhousegames.com

*/
package com.tronster.video
{
	import com.tronster.video.VideoSeekPoint;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Wraps Flash video operations for easy script access.
	 * 
	 * @usage
	 * 
	 * 	// Initialize
	 *	var vs:VideoStream  = new VideoStream( "foo.flv" );
	 *	vs.addEventListener( VideoStream.VIDEO_READY, onVideoReady );
	 *	vs.addEventListener( VideoStream.VIDEO_DONE, onVideoDone );
	 * 
	 *	// Playback
	 * 	private function onVideoReady( e:Event ):void {
	 * 		vs.play();
	 *  }
	 * 
	 * 	// Listen for stop
	 * 	private function onVideoDone( e:Event ):void {
	 * 		trace("Video stopped playing!");
	 *		vs.
	 *  }
	 */
	public class VideoStream extends EventDispatcher
	{
		/// Event message when video is ready to play.
		public static const VIDEO_READY	: String = "videoReady";
		
		/// Event message when video is done playing.
		public static const VIDEO_DONE	: String = "videoDone";
		
		
		// Minimal required for video
		private var connection	: NetConnection;
		private var stream		: NetStream;
		public var video		: Video;
		
		
		// Information from MetaData
		public var width		:int = 0;
		public var height		:int = 0;
		public var fps			:Number = 0;
		public var seekPoints	:Vector.<VideoSeekPoint>;
		
		// Complete path/url to video
		public var path			:String;
		
		
		/**
		 * Ctor
		 * @param	path,	to the video
		 */
		public function VideoStream( path:String ) 
		{
			seekPoints = new Vector.<VideoSeekPoint>();
			
			this.path = path;
			
			connection = new NetConnection();
			connection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus_Connection);
			connection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			connection.connect( null );
			//connection.connect( "rtmp://127.0.0.1/" );
		}
		
		override public function toString() :String {
			var output:String = "Unset video, -1x-1, 0";
			if (path != null && path.length > 0) {
				output = "\"" + path + "\", " + width + "x" + height + ", " + fps + "fps";
				var len:int = seekPoints.length;
				if ( len > 0 ) {
					output += ":";
					for each ( var vsp:VideoSeekPoint in seekPoints ) {
						output += (" / " + vsp  );
					}
				}
			}
			return output;
		}
		
		public function dispose() :void {

			if (connection != null ) {
				connection.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus_Connection);
				connection.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError);			
				connection = null;
			}

			if (stream != null) {
				stream.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus_Stream );
				stream = null;
			}
			
			video = null;
		}

		private function onNetStatus_Connection( e:NetStatusEvent ):void {
									
			//trace( "onNetStatus_Connection: " + e.info.code );

			switch( e.info.code ) 
			{
				case "NetConnection.Connect.Success":
					onConnectStream();
					break;
					
				default:
					break;
			}			
		}
		
		private function onNetStatus_Stream( e:NetStatusEvent ):void {
									
			//trace( "onNetStatus_Stream: " + e.info.code );

			switch( e.info.code ) 
			{
				case "NetStream.Play.Stop":
					dispatchEvent( new Event( VideoStream.VIDEO_DONE ) );
					break;
				
				case "NetStream.Play.StreamNotFound":
					trace("ERROR: Cannot find video '" + path + "': ");
					trace("       " + e);
					trace("       " + e.info);
					break;

				default:
					break;
			}
		}
		
		/**
		 * Wired via Flash's stream.client
		 * @param	data
		 */
		public function onMetaData( data:Object ):void 
		{ 
			//trace("onMetaData: ");
			
			var output:String = "";
			for (var tag:String in data) {
				output = "  info.'" + tag + "'";
				switch( tag ) {
					case "height":			height = data[tag]; 			break;
					case "width": 			width = data[tag]; 				break;
					case "videoframerate":	fps = data[tag];				break;
					case "seekpoints":		parseSeekPoints( data[tag] ); 	break;
					
					default:
						output += "  UNHANDLED";
						break;
				}
				
				//trace( output );
			}
			
			dispatchEvent( new Event( VIDEO_READY ) );			
		}
		
		public function onCuePoint( data:Object ) :void {
			/*
			trace("onCuePoint");
			for ( var s:String in data ) {
				trace( "  data.'" + s + "': " + data[s]);
			}
			*/
		}
		
		public function onPlayStatus( data:Object ) :void {
			trace("onPlayStatus: " + data);
		}
		
		private function parseSeekPoints( data:Object ):void {
			for (var s:String in data )
				seekPoints.push( new VideoSeekPoint( data[s] ) );
		}

		private function onSecurityError( e:SecurityErrorEvent ) :void {
			trace("onSecurityError: " + e);	
		}
		
		
		private function onConnectStream() :void 
		{
			//stream = new NetStream( connection, NetStream.DIRECT_CONNECTIONS );
			stream = new NetStream( connection );
			stream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus_Stream );

			stream.client = this;
			stream.bufferTime = 3;	// The amount of video in the buffer (in seconds) before playback can beging

			video = new Video();
			video.attachNetStream( stream );
			stream.play( path );
			stream.pause();
			stream.seek( 0 );			
		}
		
		/**
		 * Play the video stream.
		 * @param	fromStart
		 */
		public function play( fromStart:Boolean = false ) :void {
			if ( fromStart )
				stream.seek(0);
			stream.resume();
		}
		
		/**
		 * Stop the video currently playing.
		 */
		public function stop() :void {
			stream.pause();
		}
		
		
		/*	Attempt to empted H.264 and play out but docs say Netstream can take NULL?
		[Embed(source = "../lib/video/0-confident.mp4", mimeType = "application/octet-stream")]	static public var vid0:Class;
		var vid:Video = new Video();
		var nc:NetConnection = new NetConnection()l
		var ns:NetStream = new NetStream( nc );			
		ns.play(null);
		ns.appendBytes( new vid0() as ByteArray );
		vid.attachNetStream( ns );
		stage.addChild( vid );
		*/

		
	}
}

