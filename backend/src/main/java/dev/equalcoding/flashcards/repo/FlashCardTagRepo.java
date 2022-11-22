package dev.equalcoding.flashcards.repo;

import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;

public interface FlashCardTagRepo extends MongoRepository<FlashCardTag, String> {

}