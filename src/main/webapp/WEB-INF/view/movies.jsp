<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resource/bootstrap.css">
<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
<title>电影列表</title>

<script type="text/javascript">
		
	
		function morder(orderName) {
			//为空
			var orderMethod='${movievo.orderMethod}'; 

			orderMethod= orderMethod=='desc'?'asc':'desc';
			
			alert(orderMethod);
			
			
			location.href="/selects?orderName="+orderName+"&orderMethod="+orderMethod;
			
		}
		
		function fengye(pageNum) {
			$("[name=pageNum]").val(pageNum);
			$("form").submit();
		}
		
		function choose(own) {
			$("[name=check]").attr("checked",own.checked);
		}
		
		function deleteBatch() {
			
			var num = $("[name=check]:checked").size();
			if(num==0){
				alert("请选择要删除的数据")
			}else{
				var ids = "";
				$("[name=check]:checked").each(function(){
					ids+=","+this.value;
				})
				ids=ids.substring(1);
				
				$.post("/delete",{ids:ids},function(flag){
					if(flag){
						alert("批量删除成功");
						location="/selects";
					}else{
						alert("批量删除失败")
					}
					
					
				},"json")
			}a
			
		}
		
		function update(id) {
			location.href="/update?id="+id;	
		}
		
</script>

</head>
<body>
<form action="/selects" method="post">
	<input type="hidden" name="pageNum">
	电影名称:<input type="text" name="name">&nbsp;上映时间<input type="text" name="t1">--<input type="text" name="t2"><br>
	导演:<input type="text" name="actor">&nbsp;价格<input type="text" name="p1">--<input type="text" name="p2"><br>
	年代:<input type="text" name="years">&nbsp;电影时长<input type="text" name="l1">--<input type="text" name="l2"><br>
	<button type="submit" class="btn btn-info">查询</button>
</form>
	<table class="table">
		<tr>
			<td>
				<input type="checkbox" onclick="choose(this)">
			</td>
			<td>序号</td>
			<td>电影名称</td>
			<td>导演</td>
			<td>上映日期</td>
			<td><a href="javascript:morder('longtime')">电影时长</a></td>
			<td><a href="javascript:morder('price')">价格</a></td>
			<td><a href="javascript:morder('years')">年代</a></td>
			<td>类型</td>
			<td>区域</td>
			<td>状态</td>
			<td>操作</td>

		</tr>
		<c:forEach items="${movies}" var="movie" varStatus="count">
			<tr>
				<td>
					<input type="checkbox" name="check" value="${movie.id}">
				</td>
				<td>${count.count }</td>
				<td>${movie.name }</td>
				<td>${movie.actor }</td>
				<td>${movie.uptime }</td>
				<td>${movie.longtime }</td>
				<td>${movie.price  }</td>
				<td>${movie.years }</td>
				<td>${movie.type }</td>
				<td>${movie.area }</td>
				<td>
					<c:if test="${movie.status==1}">
						正在热映
					</c:if>
					<c:if test="${movie.status==2}">
						下架
					</c:if>
				
				</td>
				<td>
					<c:if test="${movie.status==1}">
						<button onclick="update(${movie.id})">下架</button>
					</c:if>
					<c:if test="${movie.status==2}">
						<button onclick="update(${movie.id})">上架</button>
					</c:if>
				</td>
			</tr>


		</c:forEach>
		
		<tr>
			<td colspan="10">
				<button onclick="fengye(1)">首页</button>
				<button onclick="fengye(${page.prePage==0?'1':page.prePage})">上一页</button>
				<button onclick="fengye(${page.nextPage==0?page.pages:page.nextPage})">下一页</button>
				<button onclick="fengye(${page.pages})">尾页</button>
				
				当前${page.pageNum}/${page.pages}页,共${page.total}条
				&nbsp;&nbsp;
				&nbsp;&nbsp;
				<button onclick="deleteBatch()">批量删除</button>
			</td>
		</tr>
	</table>
</body>
</html>