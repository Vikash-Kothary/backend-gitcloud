package com.vikashkothary.gitcloud.controller;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.vikashkothary.gitcloud.model.EmptyJsonResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/projects")
public class ProjectsController {

    @GetMapping
    public ResponseEntity<EmptyJsonResponse> index() {
        return ResponseEntity.status(HttpStatus.OK).body(new EmptyJsonResponse());
    }
}