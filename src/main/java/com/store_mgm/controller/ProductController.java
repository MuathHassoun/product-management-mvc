package com.store_mgm.controller;

import com.store_mgm.dao.CategoryDao;
import com.store_mgm.dao.ProductDao;
import com.store_mgm.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private CategoryDao categoryDao;

    @GetMapping
    public String listProducts(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("products", productDao.searchProductsByName(keyword));
            model.addAttribute("keyword", keyword);
        } else {
            model.addAttribute("products", productDao.getAllProducts());
        }
        return "products";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryDao.getAllCategories());
        return "product-form";
    }

    @PostMapping("/save")
    public String saveProduct(@ModelAttribute("product") Product product) {
        if (product.getProductId() == 0) {
            productDao.addProduct(product);
        } else {
            productDao.updateProduct(product);
        }
        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        model.addAttribute("product", productDao.getProductById(id));
        model.addAttribute("categories", categoryDao.getAllCategories());
        return "product-form";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id) {
        productDao.deleteProduct(id);
        return "redirect:/products";
    }
}