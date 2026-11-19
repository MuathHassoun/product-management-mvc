<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard | Store Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/app.css" rel="stylesheet">
</head>
<body class="landing-body">
    <main class="container landing-shell">
        <section class="landing-hero">
            <span class="eyebrow">Store Management System</span>
            <h1>Your inventory, organized.</h1>
            <p>Manage products and categories from one clean, fast and easy-to-use workspace.</p>
            <div class="d-flex flex-wrap justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-landing-primary px-4 py-2 rounded-pill">Browse products</a>
                <a href="${pageContext.request.contextPath}/categories" class="btn btn-landing-outline px-4 py-2 rounded-pill">Manage categories</a>
            </div>
        </section>
    </main>
</body>
</html>