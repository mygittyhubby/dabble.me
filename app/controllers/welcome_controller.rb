class WelcomeController < ApplicationController
  def index
    if current_user
      @last_entry = Entry.includes(:inspiration).where(:user_id => current_user).sort_by(&:date).last
    end
  end

  def redirect_vidcast
    redirect_to generate_url("https://vidcast.dabble.me#{request.fullpath.gsub('/cast','')}", :old_link => true), status: :moved_permanently
  end

  def generate_url(url, params = {})
    uri = URI(url)
    if uri.query.present?
      uri.query = uri.query.to_s + "&" + params.to_query
    end
    uri.to_s
  end  
end
