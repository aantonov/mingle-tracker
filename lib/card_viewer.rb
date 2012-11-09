
class CardViewer

  def view_cards(cards)
    printf "%-7s %-80s %-8s %-10s %-10s %-15s %-20s %-6s\n", "Num", "Card Name", "Type", "Points", "H.Rem", "Status", "Owner", "Sprint"
    cards.each do |card|
      if card.name.length > 80
        card.name = card.name.slice(0..76) + "..."
      end
      printf "#%-6s %-80s %-8s %-10s %-10s %-15s %-20s %-6s\n", card.number, card.name, card.type, card.task_points, card.hours_remaining, card.status, card.owner, card.sprint
    end
  end

end