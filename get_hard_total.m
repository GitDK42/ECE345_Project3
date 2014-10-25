% Returns the maximum sum of the given cards without exceeding 21
function total = get_hard_total(cards)
    l = length(cards);

    % Change J, Q, K to 10
    for i = 1:l
        if (cards(i) > 10)
            cards(i) = 10;
        end
    end

    total = sum(cards);
end
