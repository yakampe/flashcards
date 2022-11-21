package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;


@ExtendWith(MockitoExtension.class)
class FlashCardServiceTest {

    @Mock
    FlashCardRepo flashCardRepo;

    @InjectMocks
    FlashCardService flashCardService;

    @Test
    public void givenRandomFlashCardsWithCountGivenShouldReturnExactCount() {
        int expectedCount = 3;
        List<FlashCard> mockedList = generateFlashcardList();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getRandomFlashCardsByTag("tag", expectedCount);

        assertEquals(expectedCount, actual.size());
    }

    @Test
    public void givenRandomFlashCardWithCountHigherThanSizeShouldReturnSize() {
        int expectedCount = 5;
        int givenCount = 15;
        List<FlashCard> mockedList = generateFlashcardList();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getRandomFlashCardsByTag("tag", givenCount);

        assertEquals(expectedCount, actual.size());
    }

    @Test
    public void givenRandomFlashCardsForTagRequestedShouldGetTagAndReturnedShuffledList() {
        List<FlashCard> mockedList = generateFlashcardList();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getRandomFlashCardsByTag("tag", 3);

        assertTrue(actual.size() > 0);
        assertNotEquals(mockedList, actual);
    }

    private List<FlashCard> generateFlashcardList() {
        FlashCard a = new FlashCard();
        a.setAnswer("a");
        FlashCard b = new FlashCard();
        a.setAnswer("b");
        FlashCard c = new FlashCard();
        a.setAnswer("c");
        FlashCard d = new FlashCard();
        a.setAnswer("d");
        FlashCard e = new FlashCard();
        a.setAnswer("e");
        return List.of(a,b,c,d,e);
    }



}