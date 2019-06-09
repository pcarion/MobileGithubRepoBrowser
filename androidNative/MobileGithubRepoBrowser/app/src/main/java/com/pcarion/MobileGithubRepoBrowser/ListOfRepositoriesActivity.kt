package com.pcarion.MobileGithubRepoBrowser

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_list_of_repositories.*
import org.jetbrains.anko.AnkoLogger
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.info
import org.jetbrains.anko.uiThread
import java.net.URL

class ListOfRepositoriesActivity : AppCompatActivity(), AnkoLogger {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        var userName = intent.getStringExtra("userName")
        setContentView(R.layout.activity_list_of_repositories)
        setSupportActionBar(toolbar)
        retrieveListOfRepositories(userName)
    }

    private fun retrieveListOfRepositories(userName: String) {
        doAsync {
            info("retrieveListOfRepositories")
            //Execute all the lon running tasks here
            val jsonData: String = URL("https://api.github.com/users/$userName/repos").readText()
            info("retrieveListOfRepositories>" + jsonData)

            uiThread {
            }
        }
    }

}
