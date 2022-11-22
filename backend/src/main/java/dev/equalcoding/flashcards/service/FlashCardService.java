package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.CardProcessingType;
import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.logging.Logger;

@Service
public class FlashCardService {

    Logger logger = Logger.getLogger(FlashCardService.class.getName());

    private final FlashCardRepo flashCardRepo;
    private final FlashCardTagRepo flashCardTagRepo;

    @Autowired
    public FlashCardService(FlashCardRepo flashCardRepo, FlashCardTagRepo flashCardTagRepo) {
        this.flashCardRepo = flashCardRepo;
        this.flashCardTagRepo = flashCardTagRepo;
    }

    public void saveFlashCard(FlashCard flashCard) {
        flashCard.getTags().forEach(tag -> {
            Optional<FlashCardTag> existingTag = flashCardTagRepo.findById(tag);
            if (existingTag.isPresent()) {
                FlashCardTag flashCardTag = existingTag.get();
                flashCardTag.setCount(flashCardTag.getCount() + 1);
                flashCardTagRepo.save(flashCardTag);
            } else {
                flashCardTagRepo.save(new FlashCardTag(tag, 1, 0, 0, 0));
            }
        });
        flashCardRepo.save(flashCard);
    }

    public void processCard(FlashCard flashCard, CardProcessingType cardProcessingType) {
        processTagCollection(flashCard, cardProcessingType);
        processCardIncrementation(flashCard, cardProcessingType);
        flashCardRepo.save(flashCard);
    }

    private void processCardIncrementation(FlashCard flashCard, CardProcessingType cardProcessingType) {
        flashCard.setSeen(true);
        switch (cardProcessingType) {
            case CORRECT: {
                flashCard.incrementCorrectCount();
                break;
            }
            case INCORRECT: {
                flashCard.incrementIncorrectCount();
                break;
            }
        }
    }

    private void processTagCollection(FlashCard flashCard, CardProcessingType cardProcessingType) {
        flashCard.getTags().forEach(tag -> {
            Optional<FlashCardTag> tagObject = flashCardTagRepo.findById(tag);
            if (tagObject.isPresent()) {
                FlashCardTag flashCardTag = tagObject.get();
                processTagIncrementation(cardProcessingType, flashCardTag);
                flashCardTag.incrementSeenCount();
                if(!flashCard.isSeen() && cardProcessingType == CardProcessingType.CORRECT) {
                    flashCardTag.incrementUniqueCardsSeenCount();
                }
                flashCardTagRepo.save(flashCardTag);
            }
        });
    }

    private void processTagIncrementation(CardProcessingType cardProcessingType, FlashCardTag flashCardTag) {
        switch (cardProcessingType) {
            case CORRECT: {
                flashCardTag.incrementCorrectCount();
                break;
            }
            case INCORRECT: {
                flashCardTag.incrementIncorrectCount();
                break;
            }
        }
    }

    public List<FlashCard> getAllCards() {
        return flashCardRepo.findAll();
    }

    public List<FlashCard> getRandomFlashCardsByTag(String tag, int count) {
        List<FlashCard> allCards = new ArrayList<>();


        logger.info(allCards.toString());

        allCards.addAll(flashCardRepo.findByTags(tag));

        Collections.shuffle(allCards, new Random());

        if (count == 0 || count > allCards.size()) {
            return allCards;
        } else {
            return allCards.subList(0, count);
        }
    }
}
