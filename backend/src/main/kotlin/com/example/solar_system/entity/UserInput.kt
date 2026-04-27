package com.example.solar_system.entity

import jakarta.persistence.*

@Entity
class UserInput(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    val sessionId: Long,

    @Column(columnDefinition = "TEXT")
    val payload: String
)