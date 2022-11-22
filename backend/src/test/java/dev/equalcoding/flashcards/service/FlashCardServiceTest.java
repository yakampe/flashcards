package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.CardProcessingType;
import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;


@ExtendWith(MockitoExtension.class)
class FlashCardServiceTest {

    @Mock
    FlashCardRepo flashCardRepo;

    @Mock
    FlashCardTagRepo flashCardTagRepo;

    @InjectMocks
    FlashCardService flashCardService;

    @Test
    public void givenRandomFlashCardsWithCountGivenShouldReturnExactCount() {
        int expectedCount = 3;
        List<FlashCard> mockedList = generateFlashcardList();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getFlashCardsByTag("tag", expectedCount);

        assertEquals(expectedCount, actual.size());
    }

    @Test
    public void givenRandomFlashCardWithCountHigherThanSizeShouldReturnSize() {

        int givenCount = 1500000;
        List<FlashCard> mockedList = generateFlashcardList();
        int expectedCount = mockedList.size();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getFlashCardsByTag("tag", givenCount);

        assertEquals(expectedCount, actual.size());
    }

    @Test
    public void givenCardAnsweredCorrectlyShouldIncreaseCorrectCountForTagAndCard() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setCorrectCount(10);


        ArgumentCaptor<FlashCard> cardCaptor = ArgumentCaptor.forClass(FlashCard.class);
        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setCorrectCount(20);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());
        verify(flashCardRepo, times(1)).save(cardCaptor.capture());

        assertEquals(11, cardCaptor.getValue().getCorrectCount());
        assertEquals(21, tagCaptor.getValue().getCorrectCount());
    }

    @Test
    public void givenCardAnsweredIncorrectlyShouldIncreaseIncorrectCountForTagAndCard() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setIncorrectCount(10);


        ArgumentCaptor<FlashCard> cardCaptor = ArgumentCaptor.forClass(FlashCard.class);
        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setIncorrectCount(20);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.INCORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());
        verify(flashCardRepo, times(1)).save(cardCaptor.capture());

        assertEquals(11, cardCaptor.getValue().getIncorrectCount());
        assertEquals(21, tagCaptor.getValue().getIncorrectCount());
    }

    @Test
    public void givenCardProcessedShouldIncrementSeenCountForTag() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));

        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setCardsSeenCount(200);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.INCORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());

        assertEquals(201, tagCaptor.getValue().getCardsSeenCount());
    }

    @Test
    public void givenCardAnsweredShouldSetAsSeen() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setSeen(false);


        ArgumentCaptor<FlashCard> cardCaptor = ArgumentCaptor.forClass(FlashCard.class);
        FlashCardTag processingTag = new FlashCardTag();
        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.INCORRECT);
        verify(flashCardRepo, times(1)).save(cardCaptor.capture());

        assertTrue(cardCaptor.getValue().isSeen());
    }

    @Test
    public void givenCorrectIncrementTriggeredTheTagShouldOnlyUpdateCorrectIncrement() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setCorrectCount(10);
        processingCard.setIncorrectCount(0);


        ArgumentCaptor<FlashCard> cardCaptor = ArgumentCaptor.forClass(FlashCard.class);
        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setCorrectCount(20);
        processingTag.setIncorrectCount(0);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());
        verify(flashCardRepo, times(1)).save(cardCaptor.capture());

        assertEquals(11, cardCaptor.getValue().getCorrectCount());
        assertEquals(21, tagCaptor.getValue().getCorrectCount());
        assertEquals(0, tagCaptor.getValue().getIncorrectCount());
        assertEquals(0, tagCaptor.getValue().getIncorrectCount());
    }

    @Test
    public void givenAnUnseenCardIsProcessedCorrectlyShouldIncrementUniqueCardsSeenOfTag() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setSeen(false);

        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setUniqueCardsSeenCount(20);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());

        assertEquals(21, tagCaptor.getValue().getUniqueCardsSeenCount());
    }

    @Test
    public void givenAnUnseenCardIsProcessedIncorrectlyShouldNotIncrementUniqueCardsSeenOfTag() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setSeen(false);

        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setUniqueCardsSeenCount(20);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.INCORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());

        assertEquals(20, tagCaptor.getValue().getUniqueCardsSeenCount());
    }

    @Test
    public void givenAnUnseenCardIsProcessedCorrectlyTwiceShouldOnlyIncrementUniqueCardsSeenCountOnce() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setSeen(false);

        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setUniqueCardsSeenCount(0);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        verify(flashCardTagRepo, times(2)).save(tagCaptor.capture());

        assertEquals(1, tagCaptor.getValue().getUniqueCardsSeenCount());
    }

    @Test
    public void givenAnCardHasBeenAlreadySeenCardShouldNotIncrementUniqueCardsSeen() {
        FlashCard processingCard = new FlashCard();
        processingCard.setTags(List.of("tag"));
        processingCard.setSeen(true);

        ArgumentCaptor<FlashCardTag> tagCaptor = ArgumentCaptor.forClass(FlashCardTag.class);

        FlashCardTag processingTag = new FlashCardTag();
        processingTag.setUniqueCardsSeenCount(20);

        given(flashCardTagRepo.findById(anyString())).willReturn(Optional.of(processingTag));

        flashCardService.processCard(processingCard, CardProcessingType.CORRECT);
        verify(flashCardTagRepo, times(1)).save(tagCaptor.capture());

        assertEquals(20, tagCaptor.getValue().getUniqueCardsSeenCount());
    }

    @Test
    public void givenCardsRequestedShouldPrioritiseUnseenCards() {
        List<FlashCard> mockedList = generateTenOutOfThirteenCardsAsSeen();

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getFlashCardsByTag("tag", 20);

        assertFalse(actual.get(0).isSeen());
        assertFalse(actual.get(1).isSeen());
        assertFalse(actual.get(2).isSeen());
        assertTrue(actual.get(3).isSeen());
    }

    @Test
    public void givenCardsRequestedShouldPrioritiseUnseenCardsAndThenByHighestIncorrectAndCorrectDifference() {
        List<FlashCard> mockedList = generateTenOutOfThirteenCardsAsSeen();
        mockedList.get(3).setIncorrectCount(100);
        mockedList.get(3).setCorrectCount(0);

        mockedList.get(5).setIncorrectCount(150);
        mockedList.get(5).setCorrectCount(0);

        mockedList.get(8).setIncorrectCount(75);
        mockedList.get(8).setCorrectCount(0);

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getFlashCardsByTag("tag", 20);

        assertEquals(150, actual.get(3).getIncorrectCount());
        assertEquals(100, actual.get(4).getIncorrectCount());
        assertEquals(75, actual.get(5).getIncorrectCount());
    }

    @Test
    public void givenAllCardsSeenShouldPrioritiseOnesWithMostIncorrectAgainstCorrectAnswered() {
        List<FlashCard> mockedList = generateFlashcardList();
        mockedList.forEach(item -> item.setSeen(true));
        mockedList.get(mockedList.size() - 1).setCorrectCount(100);
        mockedList.get(mockedList.size() - 1).setIncorrectCount(200);


        mockedList.get(mockedList.size() - 5).setCorrectCount(100);
        mockedList.get(mockedList.size() - 5).setIncorrectCount(150);


        mockedList.get(mockedList.size() - 10).setCorrectCount(10);
        mockedList.get(mockedList.size() - 10).setIncorrectCount(250);

        given(flashCardRepo.findByTags(any(String.class))).willReturn(mockedList);

        List<FlashCard> actual = flashCardService.getFlashCardsByTag("tag", 20);

        assertEquals(250, actual.get(0).getIncorrectCount());
        assertEquals(200, actual.get(1).getIncorrectCount());
        assertEquals(150, actual.get(2).getIncorrectCount());
    }


    private List<FlashCard> generateFlashcardList() {
        FlashCard a = new FlashCard();
        a.setId("1");
        FlashCard b = new FlashCard();
        b.setId("2");
        FlashCard c = new FlashCard();
        c.setId("3");
        FlashCard d = new FlashCard();
        d.setId("4");
        FlashCard e = new FlashCard();
        e.setId("5");
        FlashCard f = new FlashCard();
        f.setId("6");
        FlashCard g = new FlashCard();
        f.setId("7");
        FlashCard h = new FlashCard();
        f.setId("8");
        FlashCard i = new FlashCard();
        f.setId("9");
        FlashCard j = new FlashCard();
        f.setId("10");
        FlashCard k = new FlashCard();
        f.setId("11");
        FlashCard l = new FlashCard();
        f.setId("12");
        FlashCard m = new FlashCard();
        f.setId("13");
        return List.of(a, b, c, d, e, f, g, h, i, j, k, l, m);
    }


    private List<FlashCard> generateTenOutOfThirteenCardsAsSeen() {
        List<FlashCard> flashCards = generateFlashcardList().subList(0, 13);
        for (int i = 0; i < 10; i++) {
            flashCards.get(i).setSeen(true);
        }
        return flashCards;
    }


}