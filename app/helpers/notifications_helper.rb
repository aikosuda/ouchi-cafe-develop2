module NotificationsHelper
	# 未確認の通知の有無
  	def unchecked_notifications
    	@notifications = current_user.passive_notifications.where(checked: false)
  	end

  	def notification_form(notification)
  		@visitor = notification.visitor
 		@blog_comment = nil
 		@visitor_comment = notification.blog_comment_id
  		case notification.action
    		when "follow"
      			tag.a(notification.visitor.name, href: user_my_page_path(@visitor)) + 'さんがあなたをフォローしました'
    		when "favorite" then
    			if notification.review_id.blank?
	      			tag.a(notification.visitor.name, href: user_my_page_path(@visitor)) + 'さんが' + tag.a('あなたのブログ記事', href: blog_path(notification.blog_id)) + 'にいいねしました'
	      		else
	      			tag.a(notification.visitor.name, href: user_my_page_path(@visitor)) + 'さんが' + tag.a('あなたのレビュー', href: review_path(notification.review_id)) + 'にいいねしました'
	      		end
    		when "comment" then
      			@blog_comment = BlogComment.find_by(id: @visitor_comment)
      			@blog_title =@blog_comment.blog.title
      			tag.a(@visitor.name, href: user_my_page_path(@visitor)) + 'さんが' + tag.a("#{@blog_title}", href: blog_path(notification.blog_id)) + 'にコメントしました'
  		end
	end
end
