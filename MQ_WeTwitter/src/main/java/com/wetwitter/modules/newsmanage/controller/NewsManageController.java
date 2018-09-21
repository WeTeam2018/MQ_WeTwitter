package com.wetwitter.modules.newsmanage.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wetwitter.modules.common.model.News;
import com.wetwitter.modules.common.model.Result;
import com.wetwitter.modules.common.utils.JsonUtils;
import com.wetwitter.modules.mqrepository.RabbitMqProducer;
import com.wetwitter.modules.newsmanage.service.NewsManageService;

@Controller
@RequestMapping(value="/newsManageService")
public class NewsManageController 
{
	@Autowired
	private NewsManageService newsManageService;
	
	@Autowired
	private RabbitMqProducer rabbitMqProducer;
	
	@RequestMapping(value="/toConfirmList.do")
	public ModelAndView toConfirmList(HttpServletRequest request) 
			throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession();
		Map<String,Object> loginInfo = (Map<String, Object>) session.getAttribute("loginInfo");
		List<News> newsList = newsManageService.qryToConfirmFriendNews(loginInfo);
		modelAndView.addObject("newsList", newsList);
		modelAndView.setViewName("/newsList");
		return modelAndView;
	}
	
	@RequestMapping(value="/personalNewsSend.do")
	@ResponseBody
	public Result personalNewsSend(@RequestBody String jsonStr,HttpServletRequest request) 
			throws Exception
	{
		Result result = Result.fail();
		Map<String,Object> reqMap = JsonUtils.toMap(jsonStr);
		HttpSession session = request.getSession();
		Map<String,Object> loginInfo = (Map<String, Object>) session.getAttribute("loginInfo");
		String routKey = "personal." + MapUtils.getString(loginInfo, "user_name") + "." + 
				MapUtils.getString(reqMap, "receiver_name");
		rabbitMqProducer.sendRabbitmqTopic(routKey, MapUtils.getString(reqMap, "message"));
		result = Result.success();
		return result;
	}

}
