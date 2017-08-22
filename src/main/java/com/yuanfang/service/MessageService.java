package com.yuanfang.service;

import com.github.pagehelper.PageInfo;
import com.yuanfang.bean.Message;

import java.util.List;

/**
 * Created by dllo on 17/8/22.
 */
public interface MessageService {
    List<Message> findAll();

    PageInfo<Message> queryPage(Integer pageNum,Integer pageSize);

    Message addContent(Message message);

    Integer delete(Integer id);
}
