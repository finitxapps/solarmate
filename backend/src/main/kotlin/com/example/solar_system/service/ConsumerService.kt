package com.example.solar_system.service

import com.example.solar_system.dto.request.AddConsumerRequest
import com.example.solar_system.entity.ConsumerEntity
import com.example.solar_system.repository.ConsumerRepository
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class ConsumerService(
    private val consumerRepository: ConsumerRepository
) {
    fun addConsumer(request: AddConsumerRequest): ConsumerEntity {
        if (request.surgeWattage < request.normalWattage) {
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "surgeWattage must be greater than or equal to normalWattage"
            )
        }

        if (request.type.equals("AC", ignoreCase = true) && request.amperControl == null) {
            throw ResponseStatusException(
                HttpStatus.BAD_REQUEST,
                "amperControl is required when type is AC"
            )
        }

        val consumer = ConsumerEntity(
            consumerType = request.consumerType,
            type = request.type,
            normalWattage = request.normalWattage,
            surgeWattage = request.surgeWattage,
            inverter = request.inverter,
            amperControl = request.amperControl,
            features = request.features
        )

        return consumerRepository.save(consumer)
    }

    fun getConsumers(): List<ConsumerEntity> {
        return consumerRepository.findAll()
    }
}
