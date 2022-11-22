package dev.equalcoding.flashcards.models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Comparator;
import java.util.List;

@Document(collection = "flash-card-items")
public class FlashCard implements Comparable<FlashCard> {

    @Id
    private String id;
    private String question;
    private String answer;
    private List<String> tags;
    private int correctCount;
    private int incorrectCount;
    private boolean seen;

    public void incrementCorrectCount() {
        correctCount += 1;
    }

    public FlashCard(){};

    public FlashCard(String question, String answer, List<String> tags) {
        this.question = question;
        this.answer = answer;
        this.tags = tags;
    }

    public void setId(String id) {
        this.id = id;
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

    public boolean isSeen() {
        return seen;
    }

    public void setSeen(boolean seen) {
        this.seen = seen;
    }

    public String getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public void incrementIncorrectCount() {
        incorrectCount += 1;
    }



    @Override
    public int compareTo(FlashCard flashCard) {
        //Seen cards go last
        //Most incorrect cards will be prioritised
        int correctness = this.incorrectCount - this.correctCount;
        int comparableCorrectness = flashCard.incorrectCount - flashCard.correctCount;
        if(comparableCorrectness > correctness) return 1;
        return -1;
    }
}
