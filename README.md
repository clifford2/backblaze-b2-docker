Backblaze B2 [CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) container image.

Based on <https://github.com/tianon/dockerfiles/tree/master/backblaze-b2>, with these changes:

- Updated b2 version (based on releases at <https://github.com/Backblaze/B2_Command_Line_Tool>)
- Added entrypoint

Build with:

	docker build --pull -t cliffordw/backblaze-b2 .

Usage:

	CONFDIR=$HOME/b2config
	test -d $CONFDIR || mkdir -p $CONFDIR
	docker run --rm -it -u $(id -u) -v $CONFDIR:/home/b2 -v $PWD:/data -w /data cliffordw/backblaze-b2 authorize-account
	docker run --rm -it -u $(id -u) -v $CONFDIR:/home/b2 -v $PWD:/data -w /data cliffordw/backblaze-b2 <command>
