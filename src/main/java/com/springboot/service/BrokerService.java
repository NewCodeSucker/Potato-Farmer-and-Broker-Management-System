package com.springboot.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.model.Broker;
import com.springboot.repository.BrokerRepository;

@Service
public class BrokerService {

    @Autowired
    private BrokerRepository brokerRepository;

    public Optional<Broker> findByUserName(String userName){
        return brokerRepository.findByUserName(userName);
    }

    public Broker save(Broker broker){
        return brokerRepository.save(broker);
    }

}