module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Sample App"
		if page_title.empty?
			base_title
		else 
			page_title + " | " + base_title
		end		
	end

	def current_user?(user)
      user == current_user
    end

    def following_user?(user)
    	following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
        User.where(":needcheck_id in (#{following_ids})",user_id: current_user.id, needcheck_id: user.id).count > 0
    end
end
