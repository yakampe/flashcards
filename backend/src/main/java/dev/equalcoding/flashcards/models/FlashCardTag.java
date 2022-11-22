package dev.equalcoding.flashcards.models;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "flash-card-tags")
public class FlashCardTag {
    @Id
    String tag;
    int count;
    int correctCount;
    int incorrectCount;
    int cardsSeenCount;

    public FlashCardTag(String tag, int count, int correctCount, int incorrectCount, int cardsSeenCount) {
        this.tag = tag;
        this.count = count;
        this.correctCount = correctCount;
        this.incorrectCount = incorrectCount;
        this.cardsSeenCount = cardsSeenCount;
    }



    public int getCorrectCount() {
        return correctCount;
    }

    public void setCorrectCount(int correctCount) {
        this.correctCount = correctCount;
    }

    public int getIncorrectCount() {
        return incorrectCount;
    }

    public void setIncorrectCount(int incorrectCount) {
        this.incorrectCount = incorrectCount;
    }

    public int getCardsSeenCount() {
        return cardsSeenCount;
    }

    public void setCardsSeenCount(int cardsSeenCount) {
        this.cardsSeenCount = cardsSeenCount;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
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