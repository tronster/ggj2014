package  
{
	public function assert( statement:*, message:String ):void 
	{
		CONFIG::debug
		{
			if ( statement )
				return;
			trace( "3:" + message );
			null();
		}
	}
}