package com.wetwitter.modules.mqrepository.business;

import javax.websocket.Session;
import org.apache.log4j.Logger;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.core.ChannelAwareMessageListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.rabbitmq.client.Channel;
import com.wetwitter.modules.common.socket.WebSocketServerEndpoint;

@Component
public class PersonalQueueBusiness implements ChannelAwareMessageListener 
{
	private static Logger logger = Logger.getLogger(PersonalQueueBusiness.class);

	@Autowired
    private WebSocketServerEndpoint webSocketServerEndpoin;
    
	public PersonalQueueBusiness() 
	{
	}

	@Override
	public void onMessage(Message message, Channel channel) throws Exception {
		logger.info(
				"消费端接收到消息:" + message.getMessageProperties() + ":" + new String(message.getBody()));
		
    	logger.info("topic:"+message.getMessageProperties().getReceivedRoutingKey());
//    	String receiverUserName = message.getMessageProperties().getReceivedRoutingKey().split("\\.")[2];
//    	String senderUserName = message.getMessageProperties().getReceivedRoutingKey().split("\\.")[1];
		webSocketServerEndpoin.sendMessage(message.getMessageProperties().getReceivedRoutingKey(), new String(message.getBody()));
//		if(success){
			//消费成功，从队列中删除消息
			channel.basicAck(message.getMessageProperties().getDeliveryTag(), false); // false只确认当前一个消息收到，true确认所有consumer获得的消息
//		}else {
//			//对方客户端未上线，消费失败，重新放入队列
//			channel.basicReject(message.getMessageProperties().getDeliveryTag(), true);
//		}
	}
	
}
