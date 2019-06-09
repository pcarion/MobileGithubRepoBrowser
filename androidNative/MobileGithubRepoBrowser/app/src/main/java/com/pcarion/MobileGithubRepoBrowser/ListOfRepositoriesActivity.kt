package com.pcarion.MobileGithubRepoBrowser

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import com.google.gson.Gson
import com.pcarion.MobileGithubRepoBrowser.data.GithubRepository
import kotlinx.android.synthetic.main.activity_list_of_repositories.*
import kotlinx.android.synthetic.main.content_list_of_repositories.*
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
            var gson = Gson()
            var repoList = gson.fromJson(jsonData, Array<GithubRepository>::class.java)
            info("RepoList: " + repoList)

            uiThread {
                // Create the adapter to convert the array to views
                val adapter = ListOfRepositoriesAdapter(this@ListOfRepositoriesActivity, repoList)
                listOfRepos.setAdapter(adapter)
            }
        }
    }

}
