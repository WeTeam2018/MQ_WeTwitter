package com.wetwitter.modules.common.listener;

import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import org.apache.commons.collections4.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import com.wetwitter.modules.common.dao.UserDao;
import com.wetwitter.modules.common.model.User;

/**
 * session监听，主要是为了
 * 用户session销毁时更改用户在线状态
 * @author sunwei
 */

@WebListener
public class UserSessionListener {
	
	@Autowired
	private UserDao userDao;

	public void sessionCreated(HttpSessionEvent arg0) {
			ServletContext context = arg0.getSession().getServletContext();
			if (context.getAttribute("count")==null) {
				context.setAttribute("count", 0);
			}else {
				int count = (Integer) context.getAttribute("count");
				context.setAttribute("count", count+1);
			}
	}
	
	public void sessionDestroyed(HttpSessionEvent arg0) {
		ServletContext context = arg0.getSession().getServletContext();
		if (context.getAttribute("count")==null) {
			context.setAttribute("count", 0);
		}else {
			int count = (Integer) context.getAttribute("count");
			if (count<1) {
				count = 1;
			}
			context.setAttribute("count", count-1);
		}
		HttpSession session = arg0.getSession();
		Map<String,Object> loginInfo = (Map<String, Object>) session.getAttribute("loginInfo");
		User user = new User();
		user.setUserId(MapUtils.getString(loginInfo, "user_id"));
		user.setUserState(0);
		try {
			userDao.modifyUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
