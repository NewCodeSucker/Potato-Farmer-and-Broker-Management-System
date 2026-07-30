package com.springboot.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.springboot.model.ItemRequisition;

public interface ItemRequisitionRepository
        extends JpaRepository<ItemRequisition, Integer> {

    /*
     * ===========================
     * FARMER
     * ===========================
     */

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        JOIN requisition.cycle register
        JOIN register.farmlands land
        WHERE land.farmer.farmerId = :farmerId
          AND (
                requisition.requisitionType IS NULL
                OR UPPER(requisition.requisitionType)
                   <> 'INITIAL_ALLOCATION'
              )
          AND (
                :registerId IS NULL
                OR register.registerId = :registerId
              )
          AND (
                :status IS NULL
                OR :status = ''
                OR UPPER(requisition.status) = UPPER(:status)
              )
        ORDER BY requisition.requisitionId DESC
    """)
    List<ItemRequisition> findFarmerRequisitions(
            @Param("farmerId") int farmerId,
            @Param("registerId") Integer registerId,
            @Param("status") String status
    );

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        JOIN FETCH requisition.cycle register
        JOIN FETCH register.cycle cropCycle
        LEFT JOIN FETCH requisition.details detail
        LEFT JOIN FETCH detail.item
        JOIN register.farmlands land
        WHERE requisition.requisitionId = :requisitionId
          AND land.farmer.farmerId = :farmerId
          AND (
                requisition.requisitionType IS NULL
                OR UPPER(requisition.requisitionType)
                   <> 'INITIAL_ALLOCATION'
              )
    """)
    Optional<ItemRequisition> findByIdAndFarmerIdWithDetails(
            @Param("requisitionId") int requisitionId,
            @Param("farmerId") int farmerId
    );

    /*
     * ===========================
     * BROKER LIST
     * ===========================
     *
     * รับทั้ง:
     * requisitionType = NULL
     * requisitionType = FARMER_REQUEST
     *
     * ไม่รับ:
     * requisitionType = INITIAL_ALLOCATION
     */

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        JOIN FETCH requisition.cycle register
        JOIN FETCH register.cycle cropCycle
        WHERE (
                requisition.requisitionType IS NULL
                OR UPPER(requisition.requisitionType)
                   <> 'INITIAL_ALLOCATION'
              )
          AND (
                :cycleId IS NULL
                OR cropCycle.cyleId = :cycleId
              )
          AND (
                :status IS NULL
                OR :status = ''
                OR UPPER(requisition.status) = UPPER(:status)
              )
        ORDER BY requisition.requisitionId DESC
    """)
    List<ItemRequisition> findBrokerRequisitions(
            @Param("cycleId") Integer cycleId,
            @Param("status") String status
    );

    /*
     * ===========================
     * BROKER DETAIL
     * ===========================
     */

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        JOIN FETCH requisition.cycle register
        JOIN FETCH register.cycle cropCycle
        LEFT JOIN FETCH requisition.details detail
        LEFT JOIN FETCH detail.item
        WHERE requisition.requisitionId = :requisitionId
          AND (
                requisition.requisitionType IS NULL
                OR UPPER(requisition.requisitionType)
                   <> 'INITIAL_ALLOCATION'
              )
    """)
    Optional<ItemRequisition> findBrokerRequisitionDetail(
            @Param("requisitionId") int requisitionId
    );

    /*
     * ===========================
     * INITIAL ALLOCATION
     * ===========================
     */

    boolean existsByCycleRegisterIdAndRequisitionType(
            int registerId,
            String requisitionType
    );

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        LEFT JOIN FETCH requisition.details detail
        LEFT JOIN FETCH detail.item
        WHERE requisition.cycle.registerId = :registerId
          AND UPPER(requisition.requisitionType) = UPPER(:type)
    """)
    Optional<ItemRequisition> findByRegisterIdAndTypeWithDetails(
            @Param("registerId") int registerId,
            @Param("type") String type
    );

    @Query("""
        SELECT DISTINCT requisition
        FROM ItemRequisition requisition
        LEFT JOIN FETCH requisition.details detail
        LEFT JOIN FETCH detail.item
        WHERE requisition.cycle.registerId = :registerId
        ORDER BY requisition.submitDate ASC,
                 requisition.requisitionId ASC
    """)
    List<ItemRequisition> findAllByRegisterIdWithDetails(
            @Param("registerId") int registerId
    );
    
    @Query("""
            SELECT DISTINCT requisition
            FROM ItemRequisition requisition
            LEFT JOIN FETCH requisition.details detail
            LEFT JOIN FETCH detail.item
            WHERE requisition.cycle.registerId = :registerId
              AND requisition.status = 'APPROVED'
            ORDER BY requisition.submitDate ASC,
                     requisition.requisitionId ASC
        """)
        List<ItemRequisition> findApprovedWithDetailsByRegisterId(
                @Param("registerId") int registerId
        );

    
}