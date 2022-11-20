package dev.equalcoding.flashcards.rest;

import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import dev.equalcoding.flashcards.service.FlashCardService;
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
    FlashCardRepo flashCardRepo;

    @Autowired
    FlashCardService flashCardService;

    @Autowired
    FlashCardTagRepo flashCardTagRepo;

    @PostMapping("flashcards")
    public ResponseEntity<Void> addFlashCard(@RequestBody FlashCard flashCard) {
        flashCardService.saveFlashCard(flashCard);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("flashcards")
    public ResponseEntity<List<FlashCard>> getAllFlashCards() {
        List<FlashCard> flashCards = new ArrayList<>();
        flashCardRepo.findAll().forEach(flashCards::add);
        return ResponseEntity.ok(flashCards);
    }

    @GetMapping("flashcards/tags/{tag}")
    public ResponseEntity<List<FlashCard>> getFlashCardsByTag(@PathVariable String tag) {
        return ResponseEntity.ok(flashCardRepo.findByTags(tag));
    }


    @GetMapping("tags")
    public ResponseEntity<List<FlashCardTag>> getAllTags() {
        return ResponseEntity.ok(flashCardTagRepo.findAll());
    }


}
