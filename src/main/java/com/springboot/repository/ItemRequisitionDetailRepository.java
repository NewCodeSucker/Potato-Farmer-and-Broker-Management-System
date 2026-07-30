package com.springboot.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.springboot.model.ItemRequisitionDetail;

public interface ItemRequisitionDetailRepository
        extends JpaRepository<ItemRequisitionDetail, Integer> {

    @Query("""
        SELECT detail
        FROM ItemRequisitionDetail detail
        JOIN FETCH detail.item
        WHERE detail.itemRequisition.requisitionId = :requisitionId
        ORDER BY detail.requisitionDetailId ASC
    """)
    List<ItemRequisitionDetail> findByRequisitionIdWithItem(
            @Param("requisitionId") int requisitionId
    );

    long countByItemRequisitionRequisitionId(
            int requisitionId
    );
}