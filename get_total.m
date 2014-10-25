% Returns the maximum sum of the given cards without exceeding 21
function total = get_total(cards)
    one_as_eleven = get_soft_total(cards);
    one_as_one = get_soft_total(cards);

    % Pick whichever is larger but doesn't exceed 21
    if (one_as_eleven > 21)
        total = one_as_one;
    else
        total = one_as_eleven;
    end
end
