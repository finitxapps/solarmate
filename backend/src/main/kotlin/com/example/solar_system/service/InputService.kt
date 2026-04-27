package com.example.solar_system.service

import com.fasterxml.jackson.databind.ObjectMapper
import com.example.solar_system.dto.InputRequest
import com.example.solar_system.entity.UserInput
import com.example.solar_system.repository.UserInputRepository
import org.springframework.stereotype.Service

@Service
class InputService(
    private val repo: UserInputRepository,
    private val objectMapper: ObjectMapper
) {

    fun save(request: InputRequest): String {

        val jsonString = objectMapper.writeValueAsString(request.data)

        repo.save(
            UserInput(
                sessionId = request.sessionId,
                payload = jsonString
            )
        )

        return "Saved"
    }
}