package com.example.solar_system.repository

import com.example.solar_system.entity.ConsumerEntity
import org.springframework.data.jpa.repository.JpaRepository
import java.util.UUID

interface ConsumerRepository : JpaRepository<ConsumerEntity, UUID>
