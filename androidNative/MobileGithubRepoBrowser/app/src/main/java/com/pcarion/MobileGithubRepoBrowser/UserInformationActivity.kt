package com.pcarion.MobileGithubRepoBrowser

import android.os.Bundle
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_user_information.*
import android.widget.Toast
import android.os.AsyncTask
import com.google.gson.Gson
import com.pcarion.MobileGithubRepoBrowser.data.GithubUser
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.content_user_information.*
import org.jetbrains.anko.*
import java.net.URL


class UserInformationActivity : AppCompatActivity(), AnkoLogger {
    var userName: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_user_information)
        setSupportActionBar(toolbar)
        retrieveUserInformation()
    }

    private fun retrieveUserInformation() {
        var userName = intent.getStringExtra("userName")
        doAsync {
            info("retrieveUserInformation")
            //Execute all the lon running tasks here
            val jsonData: String = URL("https://api.github.com/users/$userName").readText()
            info("retrieveUserInformation>" + jsonData)
            info("imageAvatar>" + imageAvatar)
            var gson = Gson()
            var userEntity = gson.fromJson(jsonData, GithubUser::class.java)

            uiThread {
                //Update the UI thread here
                labelName.setText(userEntity.name)
                labelEmail.setText(userEntity.email)
                labelCompany.setText(userEntity.company)
                labelLocation.setText(userEntity.location)
                labelBio.setText(userEntity.bio)
                labelPublicRepos.setText(userEntity.public_repos.toString())
                labelFollowers.setText(userEntity.followers.toString())
                labelFollowings.setText(userEntity.following.toString())
                Picasso.get()
                    .load(userEntity.avatar_url)
                    .into(imageAvatar);
            }
        }
    }
}
