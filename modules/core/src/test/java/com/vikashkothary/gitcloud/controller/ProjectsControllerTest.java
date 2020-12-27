package com.vikashkothary.gitcloud.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vikashkothary.gitcloud.model.EmptyJsonResponse;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;


import static org.hamcrest.Matchers.equalTo;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class ProjectsControllerTest {

    private static final String API_PROJECTS_ENDPOINT = "/api/v1/projects";

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void getHello() throws Exception {
        final String expectedResponse = "{}";

        mockMvc.perform(get(API_PROJECTS_ENDPOINT)
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string(equalTo(expectedResponse)));
    }
}
