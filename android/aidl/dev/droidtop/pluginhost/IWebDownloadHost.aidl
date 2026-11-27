package dev.droidtop.pluginhost;

import dev.droidtop.pluginhost.IWebDownloadProvider;

/** API 26+ body-only relay, independent of embedded surface support. */
oneway interface IWebDownloadHost {
    void connected(IWebDownloadProvider provider, in String[] capabilities);
    void download(String token, String offerId, String metadataJson);
}
