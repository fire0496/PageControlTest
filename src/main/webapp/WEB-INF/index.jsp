<%--
  Created by IntelliJ IDEA.
  User: dllo
  Date: 17/8/18
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>留言板</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <script src="js/jquery-3.0.0.js" type="text/javascript"></script>

</head>
<body>
<%--bootcss样式网址--%>
<%--http://v3.bootcss.com--%>
<%--两侧留白--%>
<div class="container">
    <%--导航栏 通过 col-md-6 col-md-offset-1 改变布局--%>
    <%--<button type="button" class="btn btn-primary col-md-6 col-md-offset-1">（首选项）Primary</button>--%>

    <%--输入栏--%>
    <div class="input-group">
        <input id="content" type="text" class="form-control" placeholder="请输入留言...">
        <span class="input-group-btn">
        <button id="btn" class="btn btn-default" type="button">发送</button>
      </span>
    </div>
    <%--表格--%>
    <table id="tab" class="table table-hover">

    </table>
</div>

</body>
<script>
    //给按钮添加一个点击方法,获取输入框中的内容
    $("#btn").click(function () {
        // 1. 发送输入框的消息给服务器
        // >1. 首先定义一个消息发送的请求地址
        //  地址: localhost/addnew
        //  发送参数: content=xxx
        //  返回参数: content=xxx
        //  注意:实际工作中上述参数,都应该是参数列表
        // >2. 使用ajax请求数据

        //使用jq发送请求
        $.ajax({
            //请求的地址
            url: "/addnew",
            //请求的方式(method)
            type: "get",
            //请求附带的参数列表
            data: {content: $("#content").val()},
            //请求成功的回调方法:最终处理数据的方法
            success: function (result) {
                //result:请求回来的数据
                console.log(result);
                addNewTR(result.id, result.content,result.up, result.down, true)
            }
        });


        //2. 将发送成功的消息显示到table中
    });


    function addNewTR(id, content, upCount, downCount, how) {
        var tdleft = $("<td></td>").html("<p>" + content + "</p>");
        var tdright = $("<td></td>");
        //父标签 append 子标签
        tdright.append("顶:");
        //子标签 appendTo 父标签
        $("<a href='#'></a>").html(upCount).appendTo(tdright);
        tdright.append("踩:");
        $("<a href='#'></a>").html(downCount).appendTo(tdright);
        //删除
        $("<a href='#'>删除</a>").appendTo(tdright).attr("num", id).click(delfunc);

        //将左右两个td添加到tr中
        //<tr id="ss3"></tr>
        var trOb = $("<tr></tr>").append(tdleft).append(tdright).attr("id", "ss" + id);

        //将生成的tr最终添加到写好的table中
        if(how == true){
            $("#tab").prepend(trOb)
        } else {
            $("#tab").append(trOb)
        }
    }

    // 新需求: 显示历史消息
    // 要求: 每次加载完页面,要显示所有的历史消息

    function getAllMessage() {
        //从服务器请求数据到前端页面
        $.ajax({
            url: "/getall",
            success: function (result) {
                for (var i = 0; i < result.length; i++) {
                    //遍历返回的数据,一次在table中添加一行
                    var msg = result[i];
                    addNewTR(msg.id, msg.content, msg.up, msg.down, true)
                }
            }
        })
    }
    //页面加载完毕,去请求所有的消息数据
    getAllMessage();

    //前后端分离的开发模式
    // 1. 前后端责任分离:
    //   前端只负责将数据部署到复杂的页面中
    //   后台只负责将数据库中的数据整合后发送json/xml给前端
    // 2. 系统的耦合性降低
    //   前后端之间的交流仅限ajax和json数据
    // 3. 降低了维护成本
    //   前端的问题只由前端负责,后台的问题只由后台负责
    //   前后端出现了人员变动,对另一边没有影响

    var delfunc = function () {
        // 拿到a标签的id值
        var aid = $(this).attr("num");
        // 将要删除的id发送给后台处理
        $.ajax({
            url:"/deleteone",
            data:{
                id:aid
            },
            success:function(){
                window.location.reload();
            }
        })
    }


</script>
</html>
