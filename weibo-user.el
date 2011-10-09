;; Copyright (C) 2011 Austin<austiny.cn@gmail.com>
          
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; id: 用户UID
;; screen_name: 微博昵称
;; name: 友好显示名称，如Bill Gates(此特性暂不支持)
;; province: 省份编码（参考省份编码表）
;; city: 城市编码（参考城市编码表）
;; location：地址
;; description: 个人描述
;; url: 用户博客地址
;; profile_image_url: 自定义图像
;; domain: 用户个性化URL
;; gender: 性别,m--男，f--女,n--未知
;; followers_count: 粉丝数
;; friends_count: 关注数
;; statuses_count: 微博数
;; favourites_count: 收藏数
;; created_at: 创建时间
;; following: 是否已关注(此特性暂不支持)
;; verified: 加V标示，是否微博认证用户 
(defstruct weibo-user id screen_name name
  province city location description url
  profile_image_url domain gender
  followers_count friends_count statuses_count favorites_count
  created_at following verified)

(defun weibo-make-user (node)
  (make-weibo-user
   :id (weibo-get-node-text node 'id)
   :screen_name (weibo-get-node-text node 'screen_name)
   :gender (weibo-get-node-text node 'gender)
   :location (weibo-get-node-text node 'location)
   :description (weibo-get-node-text node 'description)
   :followers_count (weibo-get-node-text node 'followers_count)
   :friends_count (weibo-get-node-text node 'friends_count)
   :statuses_count (weibo-get-node-text node 'statuses_count)
   :favorites_count (weibo-get-node-text node 'favorites_count)   
   :verified (weibo-get-node-text node 'verified)
   :profile_image_url (weibo-get-node-text node 'profile_image_url)))

(defun weibo-insert-user (user details_t)
  (if details_t
      (weibo-insert-user-detail user)
    (weibo-insert-user-simple user)))

(defun weibo-insert-user-detail (user)
  (insert "Not implemented"))

(defun weibo-insert-user-simple (user)
  (when user
    (weibo-insert-image (weibo-get-image-file (weibo-user-profile_image_url user)))
    (insert " ")
    (insert-text-button (weibo-user-screen_name user)
			'action (lambda (b) (weibo-show-user (button-label b)))
			'follow-link t)
    (when (string= (weibo-user-verified user) "true")
      (insert " V"))
    (insert " (" 
	    (cond ((string= (weibo-user-gender user) "m") "男")
		  ((string= (weibo-user-gender user) "f") "女")
		  (t "未知"))
	    ", " (weibo-user-location user) ") ")))

(defun weibo-show-user (screen-name &optional id)
  (message screen-name))

(provide 'weibo-user)