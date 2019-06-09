package com.pcarion.MobileGithubRepoBrowser

import android.os.Bundle
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_user_information.*
import android.widget.Toast
import android.os.AsyncTask
import org.jetbrains.anko.*
import java.net.URL


class UserInformationActivity : AppCompatActivity(), AnkoLogger {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_information)
        setSupportActionBar(toolbar)
        retrieveUserInformation()
//        task = object : AsyncTask<Void, Void, String>() {
//            override fun doInBackground(vararg params: Void): String {
//                val result = URL("<api call>").readText()
//                return requestFromServer("<api call>")
//            }
//
//            override fun onPostExecute(s: String) {
//                if (!isFinishing && !isCancelled) {
//                    Log.d("Request", s)
//                    Toast.makeText(this@ExampleActivity, "Request performed", Toast.LENGTH_LONG).show()
//                }
//            }
//        }
    }

    fun retrieveUserInformation() {
        doAsync {
            info("retrieveUserInformation")
            //Execute all the lon running tasks here
            val s: String = URL("https://api.github.com/users/intuit/repos").readText()
            info("retrieveUserInformation>" + s)
            uiThread {
                //Update the UI thread here
                alert("Downloaded data is $s", "Hi I'm an alert") {
                    yesButton { toast("Yay !") }
                    noButton { toast(":( !") }
                }.show()
            }
        }
    }
}
