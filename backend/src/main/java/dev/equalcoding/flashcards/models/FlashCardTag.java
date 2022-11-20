package dev.equalcoding.flashcards.models;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "flash-card-tags")
public class FlashCardTag {
    @Id
    String tag;

    public FlashCardTag(String tag) {
        this.tag = tag;
    }

    public FlashCardTag() {
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}