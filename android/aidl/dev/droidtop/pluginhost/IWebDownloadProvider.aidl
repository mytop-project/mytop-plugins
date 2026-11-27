package dev.droidtop.pluginhost;

import android.os.ParcelFileDescriptor;

/** One-use actual response bodies; never refetch a blob/POST response as a GET. */
interface IWebDownloadProvider {
    ParcelFileDescriptor download(String token, String offerId);
    oneway void cancelDownload(String token, String offerId);
    oneway void offerResult(String token, String offerId, boolean accepted);
}
