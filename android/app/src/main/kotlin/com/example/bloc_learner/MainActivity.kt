//package com.example.bloc_learner
//
//import android.os.Bundle
//import android.view.View
//import androidx.core.view.ViewCompat
//import androidx.core.view.WindowCompat
//import androidx.core.view.WindowInsetsCompat
//import androidx.core.view.WindowInsetsControllerCompat
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity() {
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        WindowCompat.setDecorFitsSystemWindows(window, false)
//
//        // Make the navigation bar transparent
//        window.navigationBarColor = android.graphics.Color.TRANSPARENT
//
//    }
//}

package com.example.bloc_learner

import android.content.Context
import android.content.res.Resources
import android.os.Bundle
import androidx.annotation.IntDef
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    companion object {
        const val NAVIGATION_BAR_INTERACTION_MODE_THREE_BUTTON = 0
        const val NAVIGATION_BAR_INTERACTION_MODE_TWO_BUTTON = 1
        const val NAVIGATION_BAR_INTERACTION_MODE_GESTURE = 2

        @Retention(AnnotationRetention.SOURCE)
        @IntDef(NAVIGATION_BAR_INTERACTION_MODE_THREE_BUTTON,
            NAVIGATION_BAR_INTERACTION_MODE_TWO_BUTTON,
            NAVIGATION_BAR_INTERACTION_MODE_GESTURE)
        annotation class NavigationBarInteractionMode

        @NavigationBarInteractionMode
        fun getNavigationBarInteractionMode(context: Context): Int {
            val resources: Resources = context.resources
            val resourceId = resources.getIdentifier("config_navBarInteractionMode", "integer", "android")
            return if (resourceId > 0) resources.getInteger(resourceId) else NAVIGATION_BAR_INTERACTION_MODE_THREE_BUTTON
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        WindowCompat.setDecorFitsSystemWindows(window, false)

        // Check if gesture navigation mode is active
        val isGestureNavigation = getNavigationBarInteractionMode(this) == NAVIGATION_BAR_INTERACTION_MODE_GESTURE

        if (isGestureNavigation) {
            // Make the navigation bar transparent
            window.navigationBarColor = android.graphics.Color.TRANSPARENT
        }
//        else {
//            // Use the system default for navigation bar color
//            window.navigationBarColor = getSystemNavigationBarColor()
//        }
    }

    private fun getSystemNavigationBarColor(): Int {
        val typedValue = android.util.TypedValue()
        theme.resolveAttribute(android.R.attr.navigationBarColor, typedValue, true)
        return typedValue.data
    }
}





