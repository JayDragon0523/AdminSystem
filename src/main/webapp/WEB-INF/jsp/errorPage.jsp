<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 73610
  Date: 2018/12/23
  Time: 22:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<c:if test="${!empty error}">
    <font color="red"><c:out value="${error}" /></font>
</c:if>
<body>
    错误
</body>
</html>
