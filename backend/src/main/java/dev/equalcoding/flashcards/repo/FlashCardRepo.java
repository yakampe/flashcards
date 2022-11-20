package dev.equalcoding.flashcards.repo;

import dev.equalcoding.flashcards.models.FlashCard;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface FlashCardRepo extends MongoRepository<FlashCard, String> {

    public List<FlashCard> findByTags(String tag);
}