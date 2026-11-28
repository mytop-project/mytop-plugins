package dev.droidtop.pluginhost;

import android.os.ParcelFileDescriptor;

/** web.hidden.v1. body returns a one-use reliable pipe for the bounded UTF-8 document. */
interface IWebHiddenProvider {
    oneway void start(String token);
    ParcelFileDescriptor body(String token);
    oneway void cancel(String token);
}
