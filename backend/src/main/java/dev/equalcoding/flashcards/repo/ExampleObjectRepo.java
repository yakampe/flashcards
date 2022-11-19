package dev.equalcoding.flashcards.repo;

import dev.equalcoding.flashcards.models.ExampleObject;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ExampleObjectRepo extends MongoRepository<ExampleObject, String> {

}