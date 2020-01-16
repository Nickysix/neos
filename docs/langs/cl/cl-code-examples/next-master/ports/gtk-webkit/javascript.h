/*
Copyright © 2018-2019 Atlas Engineer LLC.
Use of this file is governed by the license that can be found in LICENSE.
*/
#pragma once

#include <webkit2/webkit2.h>
#include <JavaScriptCore/JavaScript.h>
#include "server-state.h"

// Return value must be freed.
gchar *javascript_result(GObject *object, GAsyncResult *result,
	gpointer _data) {
	WebKitJavascriptResult *js_result;
	JSCValue *value;
	GError *error = NULL;
	js_result = webkit_web_view_run_javascript_finish(WEBKIT_WEB_VIEW(object), result, &error);
	if (!js_result) {
		g_warning("Error running javascript: %s", error->message);
		g_error_free(error);
		return NULL;
	}

	value = webkit_javascript_result_get_js_value(js_result);

	JSCException *exception;
	gchar *str_value;
	str_value = jsc_value_to_string(value);
	exception = jsc_context_get_exception(jsc_value_get_context(value));
	if (exception) {
		g_warning("Exception in javascript: %s", jsc_exception_get_message(exception));
		return NULL;
	}

	webkit_javascript_result_unref(js_result);
	return str_value;
}

void javascript_transform_result(GObject *object, GAsyncResult *result,
	const char *identifier, int callback_id, const char *method_name) {
	gchar *transformed_result = javascript_result(object, result, NULL);
	if (transformed_result == NULL) {
		return;
	}

	char *callback_string = g_strdup_printf("%i", callback_id);
	GVariant *params = g_variant_new(
		"(sss)",
		identifier,
		transformed_result,
		callback_string);
	g_message("RPC message: %s (buffer id, javascript, callback id) = (%s, ..., %s)",
		method_name,
		identifier,
		callback_string);
	g_debug("Javascript %s: %s", callback_string, transformed_result);

	g_free(callback_string);
	g_free(transformed_result);

	g_dbus_connection_call(state.connection,
		CORE_NAME, CORE_OBJECT_PATH, CORE_INTERFACE,
		method_name,
		params, // 'params' is floating and the call should consume it.
		NULL, G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
}
