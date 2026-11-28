package dev.droidtop.pluginhost;

import dev.droidtop.pluginhost.IWebHiddenProvider;

/** web.hidden.v1: only immutable host-owned document requests, never arbitrary script. */
interface IWebHiddenHost {
    oneway void connected(IWebHiddenProvider provider, in String[] capabilities);
    String takeRequest(String token);
    boolean authorize(String token, String url, String kind);
    oneway void result(String token, String metadataJson);
    oneway void unavailable(String token, String reason);
}
