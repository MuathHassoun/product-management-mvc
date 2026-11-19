package com.store_mgm.controller;

import com.store_mgm.dao.CategoryDao;
import com.store_mgm.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryDao categoryDao;

    @GetMapping
    public String listCategories(Model model) {
        model.addAttribute("categories", categoryDao.getAllCategories());
        model.addAttribute("category", new Category());
        return "categories";
    }

    @PostMapping("/save")
    public String saveCategory(@ModelAttribute("category") Category category) {
        if (category.getCategoryId() == 0) {
            categoryDao.addCategory(category);
        } else {
            categoryDao.updateCategory(category);
        }
        return "redirect:/categories";
    }

    @GetMapping("/edit/{id}")
    public String editCategory(@PathVariable("id") int id, Model model) {
        model.addAttribute("category", categoryDao.getCategoryById(id));
        model.addAttribute("categories", categoryDao.getAllCategories());
        return "categories";
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable("id") int id) {
        try {
            categoryDao.deleteCategory(id);
        } catch (Exception e) {
            System.err.println("Error deleting category: " + e.getMessage());
        }
        return "redirect:/categories";
    }
}