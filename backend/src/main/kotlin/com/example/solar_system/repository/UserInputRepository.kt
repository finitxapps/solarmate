package com.example.solar_system.repository


import com.example.solar_system.entity.UserInput
import org.springframework.data.jpa.repository.JpaRepository

interface UserInputRepository : JpaRepository<UserInput, Long>