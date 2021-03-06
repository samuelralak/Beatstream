# -*- encoding : utf-8 -*-
require 'logger'

class ScrobblingController < ApplicationController

    def now_playing
        expires_now # don't cache

        artist = params[:artist]
        title = params[:title]

        @user = User.find(session[:user_id])

        if @user != nil && @user.lastfm_session_key != nil
            Rails.logger.info 'Update Now Playing to "' + artist + ' - ' + title + '" for user ' + @user.username

            track = Rockstar::Track.new(artist, title)
            track.updateNowPlaying(Time.now, @user.lastfm_session_key)
        end

        respond_to do |format|
            format.json { render :nothing => true }
        end
    end

    def scrobble
        expires_now # don't cache

        artist = params[:artist]
        title = params[:title]

        @user = User.find(session[:user_id])

        if @user != nil && @user.lastfm_session_key != nil
            Rails.logger.info 'Scrobbling track "' + artist + ' - ' + title + '" for user ' + @user.username

            track = Rockstar::Track.new(artist, title)
            track.scrobble(Time.now, @user.lastfm_session_key)
        end

        respond_to do |format|
            format.json { render :nothing => true }
        end
    end

end
