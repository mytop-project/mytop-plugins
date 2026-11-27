# The plugin host's Android interface (AIDL)

The Binder interface between an Android app's plugin host and the isolated process a plugin runs in:
`IPluginRuntime`, `IPluginRuntimeCallback`, `IPluginHostBroker` and `IAppInterfaceDoor`, package
`dev.droidtop.pluginhost` (droidtop's docs/plugin-api.md). droidtop's `plugin-host` and Enginehost's app each kept
a hand-made copy, and the copies had already drifted: Enginehost's `IPluginRuntime` still described plugin contract
1, which droidtop retired on 2026-10-29 (droidtop 50e3516). These are droidtop's files, the current ones, moved here
unchanged (mytop-project/tracker#867 step 1).

This is the one Android-only part of mytop-plugins (#867 D3: platform-neutral by default; AIDL is how two Android
processes talk). An app compiles it straight from its submodule:

```kotlin
android { sourceSets.getByName("main").aidl.srcDir("../vendor/mytop-plugins/android/aidl") }
```

CI compiles every file with the Android SDK's `aidl` tool.

## Browser surfaces and contained results

`IWebViewSurfaceHost` and `IWebViewSurfaceProvider` are the optional Android 30+
remote-view boundary. A provider keeps its engine and sessions in its own process;
the host receives a `SurfaceControlViewHost.SurfacePackage`, not a Java view or
the engine's objects. `android/web-surface-v1.json` defines the named relays,
capabilities, allowed metadata and ownership rules. Its filename preserves the
initial contract name; the negotiated relay is `web.view.surface.v2`.

The existing `IPluginRuntime.attachRelay` attaches the host callback. The provider
announces support before a one-use web session token is taken. Both apps verify
the bound peer's identity and current permission; every operation belongs to that
token. Version 1 retains its original method prefix and gets no body-download
callbacks. Version 2 explicitly announces `web.download.body.v1` and
`web.browse.isolated.v1`; a missing capability is never inferred from an app name.

The surface channel carries bounded navigation/loading/error data and opaque
download offers. An accepted offer returns a one-use reliable pipe; its source URL
is provenance, not permission to re-fetch a blob or POST response. The host owns
the download job, destination, limits, progress and cancellation. File paths,
arbitrary scripts, form fields and page bodies are not control messages. Existing
`web.view` broker calls retain domain-scoped session results and the host's vault.
Isolated browse exports only HTTPS page addresses, with no session cookies or
download data. Cancellation, peer death and unclaimed offers release resources;
fallback cannot replay a token already taken by a provider.
