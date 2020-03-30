package com.wetwitter.modules.common.dao;

import java.util.List;
import java.util.Map;
import com.wetwitter.modules.common.model.User;

public interface UserDao
{
	  boolean checkUserExist(User user) throws Exception;

	  int addUser(User user) throws Exception;

	  int addUserState(User user) throws Exception;

	  Map<String,Object> qryUserByUserName(User user) throws Exception;

	  int modifyUser(User user) throws Exception;

	  List<Map<String,Object>> qryFriendsByUserName(User user) throws Exception;

	  int modifyUserState(User user) throws Exception;

	  List<Map<String,Object>> listAllUser(User user,String userId) throws Exception;

	  int addFriendApplication(Map<String,Object> paramMap) throws Exception;

	  boolean checkRepeatAddFriendApply(Map<String,Object> paramMap) throws Exception;

	  List<Map<String,Object>> listAllToConfirmFriendNews(String receiver_id) throws Exception;

	  int updateFriendApplyStatus(Map<String,Object> paramMap) throws Exception;

	  int addFriend(Map<String,Object> paramMap) throws Exception;

	  boolean isFriend(Map<String,Object> paramMap) throws Exception;

	  int saveOffLineMsg(Map<String,Object> paramMap) throws Exception;

}
