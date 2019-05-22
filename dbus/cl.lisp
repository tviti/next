(with-open-bus (bus (session-server-addresses))
  (with-introspected-object (notifications bus "/org/gtk/GDBus/TestObject" "org.gtk.GDBus.TestServer")
    (notifications "org.gtk.GDBus.TestInterface" "HelloWorld" "foo")))

(defvar *interfaces* (dbus:list-object-interfaces (with-open-bus (bus (session-server-addresses))
									 (make-object-from-introspection (bus-connection bus)  "/org/gtk/GDBus/TestObject" "org.gtk.GDBus.TestServer"))))

(dbus:list-interface-methods (first *interfaces*))
