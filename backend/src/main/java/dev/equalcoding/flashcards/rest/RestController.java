package dev.equalcoding.flashcards.rest;

import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.service.FlashCardService;
import dev.equalcoding.flashcards.service.FlashCardTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class RestController {

    @Autowired
    FlashCardService flashCardService;

    @Autowired
    FlashCardTagService flashCardTagService;

    @PostMapping("flashcards")
    public ResponseEntity<Void> addFlashCards(@RequestBody List<FlashCard> flashCards) {
        flashCards.forEach(flashCardService::saveFlashCard);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("initiate")
    public ResponseEntity<Void> initiateData(@RequestBody List<FlashCard> flashCards) {
        if(flashCardService.getAllCards().size() == 0) {
            flashCards.forEach(flashCardService::saveFlashCard);
        }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("flashcards")
    public ResponseEntity<List<FlashCard>> getAllFlashCards() {
        return ResponseEntity.ok(flashCardService.getAllCards());
    }

    @GetMapping("flashcards/tags/{tag}")
    public ResponseEntity<List<FlashCard>> getFlashCardsByTag(@PathVariable String tag,
                                                              @RequestParam(required = false, defaultValue = "0") int count) {
        return ResponseEntity.ok(flashCardService.getRandomFlashCardsByTag(tag, count));
    }


    @GetMapping("tags")
    public ResponseEntity<List<FlashCardTag>> getAllTags() {
        return ResponseEntity.ok(flashCardTagService.getAllTags());
    }


}
