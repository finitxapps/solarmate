package com.example.solar_system.dto.response

data class ConsumerResponse(
    val id: String,
    val type: String,
    val normalWattage: Int,
    val surgeWattage: Int,
    val inverter: Boolean?,
    val amperControl: Boolean?,
    val features: Map<String, Any>
)
