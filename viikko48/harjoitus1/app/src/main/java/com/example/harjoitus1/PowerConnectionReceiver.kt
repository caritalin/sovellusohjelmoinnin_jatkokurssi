package com.example.harjoitus1

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast

class PowerConnectionReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        // Tarkistetaan, onko laturi liitetty vai irrotettu
        val action = intent.action
        if (Intent.ACTION_POWER_CONNECTED == action) {
            // Laturi liitetty
            Toast.makeText(context, "Laturi kytketty", Toast.LENGTH_SHORT).show()
        } else if (Intent.ACTION_POWER_DISCONNECTED == action) {
            // Laturi irrotettu
            Toast.makeText(context, "Laturi irrotettu", Toast.LENGTH_SHORT).show()
        }
    }
}
