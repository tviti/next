#include <string.h>
#include <stdlib.h>

#include <sys/types.h>
#include <unistd.h>

#include <time.h>

#include <gio/gio.h>
#include <gio/gunixfdlist.h>

int
main (int argc, char *argv[])
{
	GError *error = NULL;
	GDBusConnection* connection = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, &error);
	if (error != NULL) {
		g_warning("Connection failed: %s", error);
	}
	GVariant *result = g_dbus_connection_call_sync(connection,
		"org.gtk.GDBus.TestServer",
		"/org/gtk/GDBus/TestObject",
		"org.gtk.GDBus.TestInterface",
		"HelloWorld",
		g_variant_new("(s)", "Foo"),
		NULL, G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
	g_message("%s", g_variant_print(result, TRUE));
  return 0;
}
