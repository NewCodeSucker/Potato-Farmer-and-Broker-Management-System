package com.springboot.dto;

import java.util.ArrayList;
import java.util.List;

public class RegisterCycleDTO {

    private List<FarmlandDTO> lands = new ArrayList<>();

    public List<FarmlandDTO> getLands() {
        return lands;
    }

    public void setLands(List<FarmlandDTO> lands) {
        this.lands = lands;
    }
}