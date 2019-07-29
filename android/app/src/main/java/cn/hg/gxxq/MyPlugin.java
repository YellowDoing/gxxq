package cn.hg.gxxq;

import android.app.DownloadManager;
import android.content.Context;
import android.net.Uri;
import android.os.Environment;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import static android.content.Context.DOWNLOAD_SERVICE;


class MyPlugin implements MethodChannel.MethodCallHandler {

    public static final String CHANNEL_NAME = "huanggan/myplugin";
    private Context mContext;
    private MainActivity mMainActivity;

    /**
     * Plugin registration.
     */
    public static void registerWith(PluginRegistry.Registrar registrar, MainActivity a) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(new MyPlugin(registrar.context(), a));
        registrar.platformViewRegistry().registerViewFactory("webview", new PlatformViewFactory(StandardMessageCodec.INSTANCE) {
            @Override
            public PlatformView create(Context context, int i, Object o) {
                return new MyWebView(context, registrar.messenger());
            }
        });
    }


    public MyPlugin(Context context,MainActivity activity) {
      mContext = context;
      mMainActivity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {

        }
    }


}