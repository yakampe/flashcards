package dev.equalcoding.flashcards.models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "flash-card-items")
public class FlashCard {

    @Id
    private String id;
    private String question;
    private String answer;
    private List<String> tags;

    public FlashCard(){};

    public FlashCard(String question, String answer, List<String> tags) {
        this.question = question;
        this.answer = answer;
        this.tags = tags;
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
}
