package com.springboot.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.Broker;

public interface BrokerRepository
        extends JpaRepository<Broker,String>{

    Optional<Broker> findByUserName(String userName);

}