Backblaze B2 [CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) container image.

Based on <https://github.com/tianon/dockerfiles/tree/master/backblaze-b2>, with these changes:

- Updated b2 version (based on releases at <https://github.com/Backblaze/B2_Command_Line_Tool>)
- Added entrypoint

Build with:

```sh
podman build --pull -t cliffordw/backblaze-b2 .
```

Usage:

```sh
CONFDIR=$HOME/b2config
test -d $CONFDIR || mkdir -p $CONFDIR
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data cliffordw/backblaze-b2 authorize-account
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data cliffordw/backblaze-b2 <command>
```
