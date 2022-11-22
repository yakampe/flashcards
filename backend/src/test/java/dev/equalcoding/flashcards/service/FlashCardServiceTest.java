package dev.equalcoding.flashcards.service;

import dev.equalcoding.flashcards.models.CardProcessingType;
import dev.equalcoding.flashcards.models.FlashCard;
import dev.equalcoding.flashcards.models.FlashCardTag;
import dev.equalcoding.flashcards.repo.FlashCardRepo;
import dev.equalcoding.flashcards.repo.FlashCardTagRepo;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.BDDMockito;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());
        verify(flashCardRepo,times(1)).save(cardCaptor.capture());

        assertEquals(11,cardCaptor.getValue().getCorrectCount());
        assertEquals(21,tagCaptor.getValue().getCorrectCount());
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());
        verify(flashCardRepo,times(1)).save(cardCaptor.capture());

        assertEquals(11,cardCaptor.getValue().getIncorrectCount());
        assertEquals(21,tagCaptor.getValue().getIncorrectCount());
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());

        assertEquals(201,tagCaptor.getValue().getCardsSeenCount());
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
        verify(flashCardRepo,times(1)).save(cardCaptor.capture());

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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());
        verify(flashCardRepo,times(1)).save(cardCaptor.capture());

        assertEquals(11,cardCaptor.getValue().getCorrectCount());
        assertEquals(21,tagCaptor.getValue().getCorrectCount());
        assertEquals(0,tagCaptor.getValue().getIncorrectCount());
        assertEquals(0,tagCaptor.getValue().getIncorrectCount());
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());

        assertEquals(21,tagCaptor.getValue().getUniqueCardsSeenCount());
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());

        assertEquals(20,tagCaptor.getValue().getUniqueCardsSeenCount());
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
        verify(flashCardTagRepo,times(2)).save(tagCaptor.capture());

        assertEquals(1,tagCaptor.getValue().getUniqueCardsSeenCount());
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
        verify(flashCardTagRepo,times(1)).save(tagCaptor.capture());

        assertEquals(20,tagCaptor.getValue().getUniqueCardsSeenCount());
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