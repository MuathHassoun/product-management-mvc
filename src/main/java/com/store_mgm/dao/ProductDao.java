package com.store_mgm.dao;

import com.store_mgm.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Product> getAllProducts() {
        String sql = "SELECT p.id AS productId, p.name AS productName, p.description, p.price, p.quantity, p.category_id AS categoryId, c.category_name AS categoryName FROM products p JOIN categories c ON p.category_id = c.category_id ORDER BY p.id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class));
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO products (name, description, price, quantity, category_id) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, product.getProductName(), product.getDescription(), product.getPrice(), product.getQuantity(), product.getCategoryId());
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, quantity = ?, category_id = ? WHERE id = ?";
        jdbcTemplate.update(sql, product.getProductName(), product.getDescription(), product.getPrice(), product.getQuantity(), product.getCategoryId(), product.getProductId());
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public Product getProductById(int id) {
        String sql = "SELECT id AS productId, name AS productName, description, price, quantity, category_id AS categoryId FROM products WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
    }

    public List<Product> searchProductsByName(String keyword) {
        String sql = "SELECT p.id AS productId, p.name AS productName, p.description, p.price, p.quantity, p.category_id AS categoryId, c.category_name AS categoryName FROM products p JOIN categories c ON p.category_id = c.category_id WHERE LOWER(p.name) LIKE ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Product.class), "%" + keyword.toLowerCase() + "%");
    }
}