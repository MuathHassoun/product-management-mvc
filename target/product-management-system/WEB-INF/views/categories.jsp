<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Categories | Store Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/app.css" rel="stylesheet">
</head>
<body class="app-body">
    <nav class="navbar navbar-expand app-navbar">
        <div class="container">
            <a class="app-brand" href="${pageContext.request.contextPath}/">
                <span class="brand-mark" aria-hidden="true">SM</span>
                <span class="brand-copy">Store Management<small>Inventory workspace</small></span>
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a>
                <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/categories">Categories</a>
            </div>
        </div>
    </nav>

    <main class="container page-shell">
        <header class="page-header">
            <div>
                <span class="eyebrow">Catalog setup</span>
                <h1>Categories</h1>
                <p>Group products so they are easy to browse and manage.</p>
            </div>
        </header>

        <div class="row g-4">
            <div class="col-lg-8 order-lg-1 order-2">
                <section class="surface-card" aria-labelledby="category-list-heading">
                    <div class="surface-card__header">
                        <h2 id="category-list-heading">Your categories</h2>
                        <span class="count-badge">${fn:length(categories)} total</span>
                    </div>
                    <c:choose>
                        <c:when test="${empty categories}">
                            <div class="empty-state">
                                <strong>No categories yet</strong>
                                <span>Create a category to start organizing your products.</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle app-table">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Category name</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cat" items="${categories}">
                                            <tr>
                                                <td class="cell-id">${cat.categoryId}</td>
                                                <td class="product-name"><c:out value="${cat.categoryName}"/></td>
                                                <td>
                                                    <div class="action-group">
                                                        <a href="${pageContext.request.contextPath}/categories/edit/${cat.categoryId}" class="btn btn-sm btn-soft">Edit</a>
                                                        <a href="${pageContext.request.contextPath}/categories/delete/${cat.categoryId}" class="btn btn-sm btn-danger-soft" data-confirm-delete="Delete this category?">Delete</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>
            </div>

            <div class="col-lg-4 order-lg-2 order-1">
                <section class="surface-card sticky-panel" aria-labelledby="category-form-heading">
                    <div class="surface-card__header">
                        <h2 id="category-form-heading">
                            <c:choose>
                                <c:when test="${category.categoryId > 0}">Edit category</c:when>
                                <c:otherwise>Add category</c:otherwise>
                            </c:choose>
                        </h2>
                    </div>
                    <div class="surface-card__body">
                        <form:form action="${pageContext.request.contextPath}/categories/save" method="post" modelAttribute="category">
                            <form:hidden path="categoryId" />
                            <div class="mb-4">
                                <label class="form-label required" for="categoryName">Category name</label>
                                <form:input path="categoryName" id="categoryName" cssClass="form-control" required="true" />
                                <div class="form-hint">Use a short name that clearly describes a group of products.</div>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary py-2">Save category</button>
                                <c:if test="${category.categoryId > 0}">
                                    <a href="${pageContext.request.contextPath}/categories" class="btn btn-outline-secondary py-2">Cancel</a>
                                </c:if>
                            </div>
                        </form:form>
                    </div>
                </section>
            </div>
        </div>
    </main>
<%@ include file="confirm-delete.jspf" %>
</body>
</html>
