package com.example.harjoitus1

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var powerStatusTextView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Etsitään TextView, johon näytetään lataustilan tiedot
        powerStatusTextView = findViewById(R.id.powerStatusTextView)
    }

    // Tämä metodi päivittää TextView-lataustilan mukaan
    fun updatePowerStatus(status: String) {
        powerStatusTextView.text = status
    }
}
