package com.example.solar_system.controller


import com.example.solar_system.dto.InputRequest
import com.example.solar_system.service.InputService
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/input")
class InputController(
    private val service: InputService
) {

    @PostMapping
    fun save(@RequestBody request: InputRequest): String {
        return service.save(request)
    }
}