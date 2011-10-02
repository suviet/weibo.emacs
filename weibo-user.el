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
  followers_count friend_count statuses_count favorites_count
  created_at following verified)

(defun weibo-make-user (node)
  (make-weibo-user
   :id (weibo-get-node-text node 'id)
   :screen_name (weibo-get-node-text node 'screen_name)
   :profile_image_url (weibo-get-node-text node 'profile_image_url)))

(provide 'weibo-user)