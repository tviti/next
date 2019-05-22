## WebKitGTK depends on Glib and GTK.
CFLAGS += `pkg-config --cflags glib-2.0 gio-unix-2.0`
LDLIBS += `pkg-config --libs glib-2.0 gio-unix-2.0`

all:  gdbus-example-server gdbus-example-unix-fd-client client

gdbus-example-server: gdbus-example-server.c
gdbus-example-unix-fd-client: gdbus-example-unix-fd-client.c
client: client.c
