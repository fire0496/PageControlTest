package com.yuanfang.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuanfang.bean.Message;
import com.yuanfang.mapper.MessageMapper;
import com.yuanfang.service.MessageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Random;

/**
 * Created by dllo on 17/8/22.
 */
@Service
public class MessageServiceImpl implements MessageService {
    private Random random = new Random();

    @Resource
    private MessageMapper mapper;

    public List<Message> findAll() {
        List<Message> messageList = mapper.findAll();
        return messageList;
    }


    //分页
    public PageInfo<Message> queryPage(Integer pageNum, Integer pageSize) {
        pageNum = pageNum == null ? 1 : pageNum;
        pageSize = pageSize == null ? 5 : pageSize;

        PageHelper.startPage(pageNum,pageSize);
        List<Message> list =mapper.findAll();

        //使用PageInfo对查询结果进行包装
        PageInfo<Message> pageInfo=new PageInfo<Message>(list);
        return pageInfo;
    }

    public Message addContent(Message message) {
        message.setUp(random.nextInt(100));
        message.setDown(random.nextInt(50));
        mapper.addContent(message);
        return message;
    }

    public Integer delete(Integer id) {
        mapper.delete(id);
        return id;
    }


}
