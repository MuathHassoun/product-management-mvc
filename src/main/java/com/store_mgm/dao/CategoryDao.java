package com.store_mgm.dao;

import com.store_mgm.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CategoryDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Category> getAllCategories() {
        return jdbcTemplate.query("SELECT * FROM categories", new BeanPropertyRowMapper<>(Category.class));
    }

    public void addCategory(Category category) {
        jdbcTemplate.update("INSERT INTO categories (category_name) VALUES (?)", category.getCategoryName());
    }

    public void updateCategory(Category category) {
        jdbcTemplate.update("UPDATE categories SET category_name = ? WHERE category_id = ?", 
                category.getCategoryName(), category.getCategoryId());
    }

    public void deleteCategory(int id) {
        jdbcTemplate.update("DELETE FROM categories WHERE category_id = ?", id);
    }
    
    public Category getCategoryById(int id) {
        return jdbcTemplate.queryForObject("SELECT * FROM categories WHERE category_id = ?", 
                new BeanPropertyRowMapper<>(Category.class), id);
    }
}