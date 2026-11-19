<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Products | Store Management</title>
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
                <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/products">Products</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/categories">Categories</a>
            </div>
        </div>
    </nav>

    <main class="container page-shell">
        <header class="page-header">
            <div>
                <span class="eyebrow">Inventory</span>
                <h1>Products</h1>
                <p>Keep your catalog organized and up to date.</p>
            </div>
            <a href="${pageContext.request.contextPath}/products/new" class="btn btn-primary px-4 py-2">Add product</a>
        </header>

        <form action="${pageContext.request.contextPath}/products" method="get" class="search-panel" role="search">
            <input type="search" name="keyword" value="<c:out value='${keyword}'/>" class="form-control" aria-label="Search products by name" placeholder="Search products by name...">
            <button class="btn btn-primary px-4" type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary px-3">Reset</a>
        </form>

        <section class="surface-card" aria-labelledby="product-list-heading">
            <div class="surface-card__header">
                <h2 id="product-list-heading">Product catalog</h2>
                <span class="count-badge">${fn:length(products)} items</span>
            </div>
            <c:choose>
                <c:when test="${empty products}">
                    <div class="empty-state">
                        <strong>No products found</strong>
                        <span>Try another search or add your first product to the catalog.</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle app-table">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Category</th>
                                    <th scope="col">Description</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Stock</th>
                                    <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="prod" items="${products}">
                                    <tr>
                                        <td class="cell-id">${prod.productId}</td>
                                        <td class="product-name"><c:out value="${prod.productName}"/></td>
                                        <td><span class="category-pill"><c:out value="${prod.categoryName}"/></span></td>
                                        <td class="product-description" title="<c:out value='${prod.description}'/>"><c:out value="${prod.description}"/></td>
                                        <td class="price-cell">$<fmt:formatNumber value="${prod.price}" pattern="#,##0.00"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${prod.quantity <= 0}">
                                                    <span class="stock-badge stock-out">Out of stock</span>
                                                </c:when>
                                                <c:when test="${prod.quantity <= 5}">
                                                    <span class="stock-badge stock-low">${prod.quantity} left</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="stock-badge stock-ok">${prod.quantity}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-group">
                                                <a href="${pageContext.request.contextPath}/products/edit/${prod.productId}" class="btn btn-sm btn-soft">Edit</a>
                                                <a href="${pageContext.request.contextPath}/products/delete/${prod.productId}" class="btn btn-sm btn-danger-soft" data-confirm-delete="Delete this product?">Delete</a>
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
    </main>
<%@ include file="confirm-delete.jspf" %>
</body>
</html>
