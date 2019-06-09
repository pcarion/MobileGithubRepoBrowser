package com.pcarion.MobileGithubRepoBrowser

import android.os.Bundle
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity;
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter

//provides view binding
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_main.*

//import android.R
//import androidx.core.view.ViewCompat.setAlpha
//import androidx.core.view.ViewCompat.animate
//import android.widget.AdapterView





class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        actionBar?.title = "Github User"
        supportActionBar?.title = "Github User"

        val listItems = arrayOf(
            "intuit",
            "facebook",
            "pcarion"
        )

        val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, listItems)
        listSuggestions.setAdapter(adapter)

        listSuggestions.onItemClickListener = object : AdapterView.OnItemClickListener {

            override  fun onItemClick(
                parent: AdapterView<*>, view: View,
                position: Int, id: Long
            ) {
                val item = parent.getItemAtPosition(position) as String
                inputUserName?.setText(item)
            }
        }

        selectButton.setOnClickListener {
            // your code to perform when the user clicks on the button
        }
    }
}
