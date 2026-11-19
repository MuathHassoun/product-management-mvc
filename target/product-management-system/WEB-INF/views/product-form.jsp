<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product | Store Management</title>
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

    <main class="container page-shell product-form-shell">
        <header class="page-header">
            <div>
                <span class="eyebrow">Product catalog</span>
                <c:choose>
                    <c:when test="${product.productId > 0}">
                        <h1>Edit product</h1>
                        <p>Update the product details below.</p>
                    </c:when>
                    <c:otherwise>
                        <h1>Add a product</h1>
                        <p>Enter the details to add a new item to your catalog.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </header>

        <section class="surface-card" aria-label="Product details">
            <div class="surface-card__body p-md-4">
                <form:form action="${pageContext.request.contextPath}/products/save" method="post" modelAttribute="product">
                    <form:hidden path="productId" />

                    <div class="row g-3 mb-3">
                        <div class="col-md-7">
                            <label class="form-label required" for="productName">Product name</label>
                            <form:input path="productName" id="productName" cssClass="form-control" required="true" />
                        </div>
                        <div class="col-md-5">
                            <label class="form-label required" for="categoryId">Category</label>
                            <form:select path="categoryId" id="categoryId" cssClass="form-select" required="true">
                                <form:option value="0" label="Select a category" disabled="true" />
                                <c:forEach var="cat" items="${categories}">
                                    <form:option value="${cat.categoryId}" label="${cat.categoryName}" />
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-sm-6">
                            <label class="form-label required" for="price">Price</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <form:input path="price" id="price" type="number" step="0.01" min="0" cssClass="form-control" required="true" />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label required" for="quantity">Quantity in stock</label>
                            <form:input path="quantity" id="quantity" type="number" min="0" cssClass="form-control" required="true" />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="description">Description</label>
                        <form:textarea path="description" id="description" cssClass="form-control" rows="3" />
                        <div class="form-hint">Add a brief description to help identify this product.</div>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary px-4 py-2">Cancel</a>
                        <button type="submit" class="btn btn-primary px-4 py-2">Save product</button>
                    </div>
                </form:form>
            </div>
        </section>
    </main>
</body>
</html>