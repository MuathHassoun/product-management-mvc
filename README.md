# Product Management System

A lightweight store inventory application for managing product records and categories. Built with Spring MVC 6 and JSP, using PostgreSQL for persistence and a responsive Bootstrap interface.

## Features

- Create, edit, and delete products
- Organize products by category
- Search products by name
- Create, edit, and delete categories
- Responsive dashboard and inventory views
- PostgreSQL-backed CRUD operations

## Tech Stack

- Java 17
- Spring MVC 6.2.8
- Spring JDBC
- JSP and JSTL
- PostgreSQL
- Bootstrap 5
- Maven
- Jakarta Servlet 6

## Project Structure

```text
product-management-mvc/
|-- README.md
`-- product-management-system/
    |-- pom.xml
    `-- src/main/
        |-- java/com/store_mgm/
        |   |-- controller/
        |   |-- dao/
        |   `-- model/
        `-- webapp/
            |-- assets/
            |-- index.jsp
            `-- WEB-INF/
                |-- spring-servlet.xml
                |-- web.xml
                `-- views/
```

## Prerequisites

- JDK 17 or newer
- Apache Maven 3.8 or newer
- PostgreSQL 13 or newer
- A Jakarta Servlet 6 compatible application server, such as Apache Tomcat 11

## Database Setup

Create a PostgreSQL database and run the following schema:

```sql
CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    description TEXT,
    price       NUMERIC(12, 2) NOT NULL,
    quantity    INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER NOT NULL REFERENCES categories(category_id)
);
```

The application datasource is configured in:

```text
product-management-system/src/main/webapp/WEB-INF/spring-servlet.xml
```

Update the `url`, `username`, and `password` properties for your PostgreSQL instance before running the application.

> **Security:** Never commit production database credentials to source control. For a production deployment, externalize the datasource values through environment variables or a secrets manager, and remove any existing credentials from `spring-servlet.xml`.

## Build and Deploy

From the repository root, build the WAR:

```bash
mvn clean package
```

If Tomcat is already running, stop it before deploying:

```bash
~/Tomcat/bin/shutdown.sh
```

Copy the WAR to Tomcat's `webapps` directory, then start Tomcat:

```bash
cp target/product-management-system.war ~/Tomcat/webapps/
~/Tomcat/bin/startup.sh
```

## Run

1. Configure PostgreSQL and create the required tables.
2. Update the datasource settings in `spring-servlet.xml`.
3. Build the application with Maven.
4. Deploy `target/product-management-system.war` to Tomcat 11.
5. Open:

```text
http://localhost:8080/product-management-system/
```

The context path may differ if the WAR is deployed under a custom name or through an IDE.

## Application Routes

| Method | Route | Purpose |
|---|---|---|
| `GET` | `/` | Dashboard |
| `GET` | `/products` | List and search products |
| `GET` | `/products/new` | Open product creation form |
| `POST` | `/products/save` | Create or update a product |
| `GET` | `/products/edit/{id}` | Open product edit form |
| `GET` | `/products/delete/{id}` | Delete a product |
| `GET` | `/categories` | List categories |
| `POST` | `/categories/save` | Create or update a category |
| `GET` | `/categories/edit/{id}` | Open category edit form |
| `GET` | `/categories/delete/{id}` | Delete a category |

## Testing

Run the Maven test lifecycle from the application module:

```bash
mvn test
```

## License

This project is licensed under the MIT License. See [LICENSE](product-management-system/LICENSE).
