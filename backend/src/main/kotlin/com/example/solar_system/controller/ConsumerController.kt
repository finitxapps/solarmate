package com.example.solar_system.controller

import com.example.solar_system.dto.request.AddConsumerRequest
import com.example.solar_system.dto.response.ConsumerResponse
import com.example.solar_system.service.ConsumerService
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/consumer")
class ConsumerController(
    private val consumerService: ConsumerService
) {
    @PostMapping
    fun addConsumer(@Valid @RequestBody request: AddConsumerRequest): ConsumerResponse {
        val saved = consumerService.addConsumer(request)

        return ConsumerResponse(
            id = saved.id?.toString().orEmpty(),
            consumerType = saved.consumerType,
            type = saved.type,
            normalWattage = saved.normalWattage,
            surgeWattage = saved.surgeWattage,
            inverter = saved.inverter,
            amperControl = saved.amperControl,
            features = saved.features
        )
    }

    @GetMapping
    fun getConsumers(): List<ConsumerResponse> {
        return consumerService.getConsumers().map {
            ConsumerResponse(
                id = it.id?.toString().orEmpty(),
                consumerType = it.consumerType,
                type = it.type,
                normalWattage = it.normalWattage,
                surgeWattage = it.surgeWattage,
                inverter = it.inverter,
                amperControl = it.amperControl,
                features = it.features
            )
        }
    }
}
