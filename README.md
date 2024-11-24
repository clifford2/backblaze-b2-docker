Backblaze B2 [CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) container image.

Based on <https://github.com/tianon/dockerfiles/tree/master/backblaze-b2>, with these changes:

- Updated b2 version (based on releases at <https://github.com/Backblaze/B2_Command_Line_Tool>)
- Added entrypoint

Build with:

```sh
podman build --pull -t docker.io/cliffordw/backblaze-b2:4.2.0 .
```

Usage:

```sh
CONFDIR=$HOME/b2config
test -d $CONFDIR || mkdir -p $CONFDIR
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data docker.io/cliffordw/backblaze-b2:4.2.0 account authorize
podman run --rm -it -v $CONFDIR:/home/b2:z -v $PWD:/data:z -w /data docker.io/cliffordw/backblaze-b2:4.2.0 <command>
```
