package cn.hg.gxxq;

import android.content.Context;
import android.graphics.Bitmap;
import android.view.LayoutInflater;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class MyWebView implements PlatformView, MethodChannel.MethodCallHandler {

    private WebView mWebView;
    private final MethodChannel methodChannel;
    private View mView;

    public MyWebView(Context context, BinaryMessenger messenger) {
        initWevView(context);
        methodChannel = new MethodChannel(messenger, "huanggan/webview");
        methodChannel.setMethodCallHandler(this);
    }

    private void initWevView(Context context) {
        mView = LayoutInflater.from(context).inflate(R.layout.webview, null);
        mWebView = mView.findViewById(R.id.web_view);
        ProgressBar progressBar = mView.findViewById(R.id.progress_bar);
        WebSettings webSettings = mWebView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        mWebView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                super.onProgressChanged(view, newProgress);
                progressBar.setProgress(newProgress);
            }
        });
        mWebView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
                progressBar.setVisibility(View.VISIBLE);
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                progressBar.setVisibility(View.GONE);
            }
        });
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if ("loadUrl".equals(methodCall.method)) {
            mWebView.clearHistory();
            mWebView.loadUrl(methodCall.argument("url"));
        }
    }

    @Override
    public View getView() {
        return mView;
    }

    @Override
    public void dispose() {

    }
}
