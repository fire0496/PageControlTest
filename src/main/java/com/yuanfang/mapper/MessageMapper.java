package com.yuanfang.mapper;

import com.yuanfang.bean.Message;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by dllo on 17/8/22.
 */
@Repository
public interface MessageMapper {
    List<Message> findAll();

    int addContent(Message message);

    Integer delete(Integer id);

}
