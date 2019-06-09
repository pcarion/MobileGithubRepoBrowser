package com.pcarion.MobileGithubRepoBrowser

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView
import com.pcarion.MobileGithubRepoBrowser.data.GithubRepository

class ListOfRepositoriesAdapter(context: Context, objects: Array<GithubRepository>) :
    ArrayAdapter<GithubRepository>(context, 0, objects) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        var convertView = convertView
        // Get the data item for this position
        val repo = getItem(position)
        // Check if an existing view is being reused, otherwise inflate the view
        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.item_repository, parent, false)
        }
        // Lookup view for data population
        val tvName = convertView!!.findViewById(R.id.name) as TextView
        val tvHome = convertView!!.findViewById(R.id.description) as TextView
        // Populate the data into the template view using the data object
        tvName.text = repo!!.name
        tvHome.text = repo!!.description
        // Return the completed view to render on screen
        return convertView
    }

}
