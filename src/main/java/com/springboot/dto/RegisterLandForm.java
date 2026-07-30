package com.springboot.dto;

import java.util.List;

public class RegisterLandForm {

    private List<FarmlandDTO> lands;

    public RegisterLandForm() {}

    public List<FarmlandDTO> getLands() {
        return lands;
    }

    public void setLands(List<FarmlandDTO> lands) {
        this.lands = lands;
    }
}