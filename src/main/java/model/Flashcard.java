package model;

import java.sql.Timestamp;

public class Flashcard {
  private int flashcardId;
  private int deckId;
  private String flashCardTitle;
  private String flashCardDetail;
  private Timestamp createdAt;
  private Timestamp updatedAt;

  public int getFlashcardId() {
    return flashcardId;
  }

  public void setFlashcardId(int flashcardId) {
    this.flashcardId = flashcardId;
  }

  public int getDeckId() {
    return deckId;
  }

  public void setDeckId(int deckId) {
    this.deckId = deckId;
  }

  public String getFlashCardTitle() {
    return flashCardTitle;
  }

  public void setFlashCardTitle(String flashCardTitle) {
    this.flashCardTitle = flashCardTitle;
  }

  public String getFlashCardDetail() {
    return flashCardDetail;
  }

  public void setFlashCardDetail(String flashCardDetail) {
    this.flashCardDetail = flashCardDetail;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  public Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }
}
