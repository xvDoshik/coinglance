package com.coinglance.coinglance

import android.appwidget.AppWidgetManager
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class CoinGlanceWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences,
    ) {
        val body = widgetData.getString("rates_lines", "Open CoinGlance to load rates")
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.coinglance_widget).apply {
                setTextViewText(R.id.widget_title, "CoinGlance")
                setTextViewText(R.id.widget_body, body)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
