package com.example.solar_system.dto.request

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Positive

data class AddConsumerRequest(
    @field:NotBlank
    val type: String,

    @field:Positive
    val normalWattage: Int,

    @field:Positive
    val surgeWattage: Int,

    val inverter: Boolean? = null,

    val amperControl: Boolean? = null,

    val features: Map<String, Any> = emptyMap()
)
