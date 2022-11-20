package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FlashCardService {

    private final FlashCardRepo flashCardRepo;
    private final FlashCardTagRepo flashCardTagRepo;

    @Autowired
    public FlashCardService(FlashCardRepo flashCardRepo, FlashCardTagRepo flashCardTagRepo) {
        this.flashCardRepo = flashCardRepo;
        this.flashCardTagRepo = flashCardTagRepo;
    }

    public void saveFlashCard(FlashCard flashCard) {
        flashCard.getTags().forEach(tag -> {
            flashCardTagRepo.save(new FlashCardTag(tag));
        });
        flashCardRepo.save(flashCard);
    }
}
