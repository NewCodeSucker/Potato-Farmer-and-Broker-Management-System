package com.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.Item;

public interface ItemRepository
        extends JpaRepository<Item, Integer> {

    List<Item> findByItemTypeOrderByItemNameAsc(
            String itemType
    );
    
    Optional<Item> findFirstByItemTypeAndItemNameContainingIgnoreCase(
            String itemType,
            String itemName
    );
}