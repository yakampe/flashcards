package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FlashCardTagService {

    private final FlashCardTagRepo flashCardTagRepo;

    @Autowired
    public FlashCardTagService(FlashCardTagRepo flashCardTagRepo) {
        this.flashCardTagRepo = flashCardTagRepo;
    }

    public List<FlashCardTag> getAllTags() {
        return flashCardTagRepo.findAll();
    }
}
