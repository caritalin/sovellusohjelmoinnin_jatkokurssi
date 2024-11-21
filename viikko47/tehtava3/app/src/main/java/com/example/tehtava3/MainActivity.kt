package com.example.tehtava3

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.google.android.gms.location.*
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat

class MainActivity : ComponentActivity() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationRequest: LocationRequest
    private lateinit var locationCallback: LocationCallback

    // Esimerkkisijainti: Tampereen keskusta
    private val defaultLatitude = 61.4982
    private val defaultLongitude = 23.7600

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Tehtava3App()
        }
    }

    @Composable
    fun Tehtava3App() {
        var latitude by remember { mutableStateOf("Fetching...") }
        var longitude by remember { mutableStateOf("Fetching...") }
        val context = LocalContext.current

        // Sijainnin hakeminen
        LaunchedEffect(Unit) {
            fusedLocationClient = LocationServices.getFusedLocationProviderClient(context)
            locationRequest = LocationRequest.create().apply {
                interval = 10000
                fastestInterval = 5000
                priority = LocationRequest.PRIORITY_HIGH_ACCURACY
            }

            locationCallback = object : LocationCallback() {
                override fun onLocationResult(locationResult: LocationResult?) {
                    locationResult ?: return
                    val location = locationResult.lastLocation
                    latitude = location.latitude.toString()
                    longitude = location.longitude.toString()
                }
            }

            // Tarkistetaan, onko sijaintilupa myönnetty
            if (ActivityCompat.checkSelfPermission(
                    context,
                    android.Manifest.permission.ACCESS_FINE_LOCATION
                ) == PackageManager.PERMISSION_GRANTED
            ) {
                // Pyydetään jatkuva sijaintipäivitys
                fusedLocationClient.requestLocationUpdates(locationRequest, locationCallback, null)
            } else {
                Toast.makeText(context, "Sijaintilupa ei ole myönnetty", Toast.LENGTH_SHORT).show()
            }
        }

        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp)
        ) {
            Text(text = "Käyttäjän sijainti:")
            Text(text = "Latitude: $latitude")
            Text(text = "Longitude: $longitude")

            Spacer(modifier = Modifier.height(16.dp))

            Text(text = "Tampereen keskusta (esimerkkisijainti):")
            Text(text = "Latitude: $defaultLatitude")
            Text(text = "Longitude: $defaultLongitude")

            Spacer(modifier = Modifier.height(16.dp))

            Button(onClick = {
                // Kartan näyttäminen Tampereen keskustan sijainnilla
                openMap(defaultLatitude, defaultLongitude, context)
            }) {
                Text(text = "Näytä kartalla")
            }
        }
    }

    // Kartan avaaminen Google Maps -sovelluksessa
    private fun openMap(latitude: Double, longitude: Double, context: Context) {
        val gmmIntentUri = android.net.Uri.parse("geo:$latitude,$longitude?q=$latitude,$longitude")
        val mapIntent = android.content.Intent(android.content.Intent.ACTION_VIEW, gmmIntentUri)
        mapIntent.setPackage("com.google.android.apps.maps")
        try {
            context.startActivity(mapIntent)
        } catch (e: Exception) {
            Toast.makeText(context, "Google Maps ei ole asennettu", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onPause() {
        super.onPause()
        fusedLocationClient.removeLocationUpdates(locationCallback) // Lopetetaan sijaintipäivitykset, kun aktiviteetti ei ole näkyvissä
    }
}
