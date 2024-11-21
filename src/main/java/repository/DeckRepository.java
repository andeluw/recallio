package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Deck;

public class DeckRepository {
  private Connection connection;

  public DeckRepository(Connection connection) {
    this.connection = connection;
  }

  public int createDeck(Deck deck) throws SQLException {
    String query = "INSERT INTO decks (user_id, d_name, d_category, d_description) VALUES (?, ?, ?, ?)";
    try {
      PreparedStatement stmt = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
      stmt.setInt(1, deck.getUserId());
      stmt.setString(2, deck.getDeckName());
      stmt.setString(3, deck.getDeckCategory());
      stmt.setString(4, deck.getDeckDescription());
      int rows = stmt.executeUpdate();
      if (rows > 0) {
        try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
          if (generatedKeys.next()) {
            return generatedKeys.getInt(1);
          }
        }
      }
      return -1;
    } catch (SQLException err) {
      throw new SQLException("Error creating deck", err);
    }
  }

  public Deck getDeckById(int deckId) throws SQLException {
    String query = "SELECT * FROM decks WHERE d_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, deckId);
      ResultSet res = stmt.executeQuery();
      Deck deck = new Deck();
      if (res.next()) {
        deck.setDeckId(res.getInt("d_id"));
        deck.setUserId(res.getInt("user_id"));
        deck.setDeckName(res.getString("d_name"));
        deck.setDeckCategory(res.getString("d_category"));
        deck.setDeckDescription(res.getString("d_description"));
        deck.setCreatedAt(res.getTimestamp("created_at"));
        deck.setUpdatedAt(res.getTimestamp("updated_at"));
        return deck;
      }
    } catch (SQLException err) {
      throw new SQLException("Error getting deck", err);
    }
    return null;
  }

  public boolean updateDeck(Deck deck) throws SQLException {
    String query = "UPDATE decks SET d_name = ?, d_category = ?, d_description = ? WHERE d_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setString(1, deck.getDeckName());
      stmt.setString(2, deck.getDeckCategory());
      stmt.setString(3, deck.getDeckDescription());
      stmt.setInt(4, deck.getDeckId());
      int res = stmt.executeUpdate();
      return res > 0;
    } catch (SQLException err) {
      throw new SQLException("Error updating deck", err);
    }
  }

  public boolean deleteDeck(Deck deck) throws SQLException {
    String query = "DELETE FROM decks WHERE d_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, deck.getDeckId());
      int res = stmt.executeUpdate();
      return res > 0;
    } catch (SQLException err) {
      throw new SQLException("Error deleting deck", err);
    }
  }

  public List<Deck> getDecksByUserId(Deck deck) {
    String query = "SELECT * FROM decks WHERE user_id = ?";
    try {
      PreparedStatement stmt = connection.prepareStatement(query);
      stmt.setInt(1, deck.getUserId());
      ResultSet res = stmt.executeQuery();
      List<Deck> decks = new ArrayList<Deck>();
      while (res.next()) {
        Deck tempDeck = new Deck();
        tempDeck.setDeckId(res.getInt("d_id"));
        tempDeck.setUserId(res.getInt("user_id"));
        tempDeck.setDeckName(res.getString("d_name"));
        tempDeck.setDeckCategory(res.getString("d_category"));
        tempDeck.setDeckDescription(res.getString("d_description"));
        tempDeck.setCreatedAt(res.getTimestamp("created_at"));
        tempDeck.setUpdatedAt(res.getTimestamp("updated_at"));
        decks.add(tempDeck);
      }
      return decks;
    } catch (SQLException err) {
      System.out.println("Error getting decks by user id");
    }
    return null;
  }
}
