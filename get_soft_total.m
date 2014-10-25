% Returns the maximum sum of the given cards without exceeding 21
function total = get_soft_total(cards)
    l = length(cards);

    % Change J, Q, K to 10
    for i = 1:l
        if (cards(i) > 10)
            cards(i) = 10;
        end
    end

    % Change only the first 1 to 11 (if we change two 1 to 11 we'll bust)
    for i = 1:l
        if (cards(i) == 1)
            cards(i) = 11;
            break;
        end
    end

    total = sum(cards);
end
