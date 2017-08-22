package com.yuanfang.controller;

import com.github.pagehelper.PageInfo;
import com.yuanfang.bean.Message;
import com.yuanfang.service.MessageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by dllo on 17/8/22.
 */
@Controller
public class MainController {
    @Resource
    private MessageService service;

    //首页
    @RequestMapping(value = "/")
    public String firstPage() {
        return "index";
    }

    //查询所有
    @RequestMapping(value = "/getall")
    @ResponseBody
    public List<Message> getAllMessage() {

        List<Message> messageList = service.findAll();

        return messageList;
    }

    //添加新内容
    @RequestMapping(value = "/addnew")
    @ResponseBody
    public Message addNewMap(Message message) {
        Message msg = service.addContent(message);
        return msg;
    }

    //删除
    @RequestMapping(value = "/deleteone")
    @ResponseBody
    public Message deleteOneMessage(@RequestParam("id") Integer id) {
        service.delete(id);
        return null;
    }


    //分页
    @RequestMapping(value = "/pagetest")
    @ResponseBody
    public PageInfo<Message>pageTest(@RequestParam("pageNum") Integer pn
                                    ,@RequestParam("pageSize") Integer ps){
        return service.queryPage(pn,ps);
    }

    @RequestMapping(value = "/test")
    @ResponseBody
    public String gittest(){
        return "bbb";
    }

    public void test(){

        System.out.println(1111);
    }


}
