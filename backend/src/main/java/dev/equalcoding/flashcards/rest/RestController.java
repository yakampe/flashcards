package dev.equalcoding.flashcards.rest;

import dev.equalcoding.flashcards.models.ExampleObject;
import dev.equalcoding.flashcards.repo.ExampleObjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/api")
public class RestController {

    @Autowired
    ExampleObjectRepo exampleObjectRepo;

    @GetMapping("add")
    public ResponseEntity<Void> test() {
        exampleObjectRepo.save(new ExampleObject("a", "b", "c"));
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("get")
    public ResponseEntity<List<ExampleObject>> get() {
        List<ExampleObject> exampleObjects = new ArrayList<>();
        exampleObjectRepo.findAll().forEach(exampleObjects::add);
        return ResponseEntity.ok(exampleObjects);
    }

}
