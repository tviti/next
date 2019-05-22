/*
Copyright © 2018-2019 Atlas Engineer LLC.
Use of this file is governed by the license that can be found in LICENSE.
*/
#pragma once

// This is kept outside of server.h because window.h also needs it.
#define PLATFORM_PORT_NAME "engineer.atlas.next.platform"
#define PLATFORM_PORT_OBJECT "/engineer/atlas/next/platform"
#define PLATFORM_PORT_INTERFACE PLATFORM_PORT_NAME

#define CORE_NAME "engineer.atlas.next.core"
#define CORE_OBJECT "/engineer/atlas/next/core"
#define CORE_INTERFACE CORE_NAME

typedef struct {
	GHashTable *windows;
	GHashTable *buffers;
	GHashTable *server_callbacks;
	GDBusConnection *connection;
} ServerState;

static ServerState state = {};
