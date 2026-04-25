package com.example.solar_system.entity

import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.Id
import jakarta.persistence.Table
import org.hibernate.annotations.JdbcTypeCode
import org.hibernate.type.SqlTypes
import java.time.LocalDateTime
import java.util.UUID

@Entity
@Table(name = "consumers")
class ConsumerEntity(
    @Id
    @GeneratedValue
    val id: UUID? = null,

    @Column(nullable = false)
    val consumerType: String = "",

    @Column(nullable = false)
    val type: String = "",

    @Column(nullable = false)
    val normalWattage: Int = 0,

    @Column(nullable = false)
    val surgeWattage: Int = 0,

    val inverter: Boolean? = null,

    val amperControl: Boolean? = null,

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb", nullable = false)
    var features: Map<String, Any> = emptyMap(),

    @Column(nullable = false)
    val createdAt: LocalDateTime = LocalDateTime.now()
)
