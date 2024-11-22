package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Deck;
import model.Flashcard;

public class FlashcardRepository {
  private Connection connection;

  public FlashcardRepository(Connection connection) {
    this.connection = connection;
  }

  public boolean createFlashcard(Flashcard flashcard) throws SQLException {
    String query = "INSERT INTO flashcards (deck_id, f_title, f_detail) VALUES (?, ?, ?)";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, flashcard.getDeckId());
      stmt.setString(2, flashcard.getFlashcardTitle());
      stmt.setString(3, flashcard.getFlashcardDetail());
      int result = stmt.executeUpdate();
      return result > 0;
    } catch (SQLException err) {
      throw new SQLException("Error creating deck", err);
    }
  }

  public List<Flashcard> getFlashcardsByDeckId(Deck deck) throws SQLException {
    String query = "SELECT * FROM flashcards WHERE deck_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, deck.getDeckId());
      ResultSet res = stmt.executeQuery();
      List<Flashcard> flashcards = new ArrayList<Flashcard>();
      while (res.next()) {
        Flashcard flashcard = new Flashcard();
        flashcard.setFlashcardId(res.getInt("f_id"));
        flashcard.setDeckId(res.getInt("deck_id"));
        flashcard.setFlashcardTitle(res.getString("f_title"));
        flashcard.setFlashcardDetail(res.getString("f_detail"));
        flashcard.setCreatedAt(res.getTimestamp("created_at"));
        flashcard.setUpdatedAt(res.getTimestamp("updated_at"));
        flashcards.add(flashcard);
      }
      return flashcards;
    } catch (SQLException err) {
      throw new SQLException("Error getting flashcards", err);
    }
  }

  public Flashcard getFlashcardById(int flashcardId) throws SQLException {
    String query = """
            SELECT *, (SELECT user_id
                    FROM decks
                    WHERE decks.d_id = flashcards.deck_id) AS user_id
            FROM flashcards
            WHERE f_id = ?;
        """;

    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, flashcardId);
      ResultSet res = stmt.executeQuery();
      Flashcard flashcard = new Flashcard();
      if (res.next()) {
        flashcard.setFlashcardId(res.getInt("f_id"));
        flashcard.setDeckId(res.getInt("deck_id"));
        flashcard.setFlashcardTitle(res.getString("f_title"));
        flashcard.setFlashcardDetail(res.getString("f_detail"));
        flashcard.setCreatedAt(res.getTimestamp("created_at"));
        flashcard.setUpdatedAt(res.getTimestamp("updated_at"));
        flashcard.setUserId(res.getInt("user_id"));
        return flashcard;
      }
      return null;
    } catch (SQLException err) {
      throw new SQLException("Error getting flashcard", err);
    }
  }

  public boolean updateFlashcard(Flashcard flashcard) throws SQLException {
    String query = "UPDATE flashcards SET f_title = ?, f_detail = ? WHERE f_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setString(1, flashcard.getFlashcardTitle());
      stmt.setString(2, flashcard.getFlashcardDetail());
      stmt.setInt(3, flashcard.getFlashcardId());
      int res = stmt.executeUpdate();
      return res > 0;
    } catch (SQLException err) {
      throw new SQLException("Error updating flashcard", err);
    }
  }

  public boolean deleteFlashcard(Flashcard flashcard) throws SQLException {
    String query = "DELETE FROM flashcards WHERE f_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, flashcard.getFlashcardId());
      int res = stmt.executeUpdate();
      return res > 0;
    } catch (SQLException err) {
      throw new SQLException("Error deleting flashcard", err);
    }
  }
}
