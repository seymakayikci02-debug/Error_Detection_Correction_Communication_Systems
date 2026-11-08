

function calculated_error = custom_calculate_error(tx_data,rx_data)
    error=(tx_data~=rx_data);
    calculated_error=mean(error(:));
end