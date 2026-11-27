package dev.droidtop.pluginhost;

import dev.droidtop.pluginhost.IWebViewSurfaceProvider;

/** web.view.surface.v1. Events are bounded, typed JSON, never script or arbitrary objects. */
oneway interface IWebViewSurfaceHost {
    void connected(IWebViewSurfaceProvider provider);
    void surfaceReady(String token);
    void unavailable(String token, String reason);
    void event(String token, String eventJson);
    void download(String token, String offerId, String metadataJson);
    void connectedCapabilities(IWebViewSurfaceProvider provider, in String[] capabilities);
}
