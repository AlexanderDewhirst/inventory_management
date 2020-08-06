window.bops = window.bops || {};

window.bops.initFilters = function() {
    $(document).ready(function() {
        $('.filterable .filters input').keyup(function(e) {
            var code = e.keyCode || e.which;
            if (code == '9') return;

            var $input = $(this);
            inputContent = $input.val().toLowerCase();
            $panel = $input.parents('.filterable');
            column = $panel.find('.filters th').index($input.parents('th'));
            $table = $panel.find('.table');

            $rows = $table.find('tbody tr[data-attr="inventory"]');

            var $filteredRows = $rows.filter(function() {
                var value = $(this).find('td').eq(column).text().toLowerCase();
                return value.indexOf(inputContent) === -1;
            });

            $table.find('tbody .no-result').remove();

            $rows.show();
            $filteredRows.hide();

            $total_row = $table.find('tbody tr[data-attr="totals"]');
            columns = [4, 5];
            window.bops.calculateAmountTotal($rows, $filteredRows, 4);
            window.bops.calculatePriceTotal($rows, $filteredRows, 5);

            if ($filteredRows.length === $rows.length) {
                $total_row.hide();
                $table.find('tbody').prepend($('<tr class="no-result text-center"><td colspan="'+ $table.find('.filters th').length +'">No Result Found.</td></tr>'));
            } else {
                $total_row.show();
            }
        });
    });
};

window.bops.calculateAmountTotal = function(rows, filtered_rows, column) {
    row_sum = window.bops.sumColumn(rows, column);
    filtered_row_sum = window.bops.sumColumn(filtered_rows, column);
    window.bops.setAmountTotal(row_sum - filtered_row_sum, column)
};

window.bops.sumColumn = function(rows, column) {
    sum = 0;
    for (i = 0; i < rows.length; i++) {
        var val = rows[i].getElementsByTagName('td')[column].getAttribute('data-value');
        sum += isNaN(val) ? 0 : parseInt(val);
    }
    return sum;
};

window.bops.setAmountTotal = function(amount, column) {
    $column_total = document.getElementById("total" + column);
    $column_total.setAttribute('data-value', amount);
    $column_total.innerHTML = amount;
};

window.bops.calculatePriceTotal = function(rows, filtered_rows, column) {
    row_sum = window.bops.calculateColumn(rows, column, 4);
    filtered_row_sum = window.bops.calculateColumn(filtered_rows, column, 4);
    window.bops.setPriceTotal(row_sum - filtered_row_sum, column);
};

window.bops.calculateColumn = function(rows, column, amount_column) {
    sum = 0;
    for (i = 0; i < rows.length; i++) {
        var price = rows[i].getElementsByTagName('td')[column].getAttribute('data-value')
        var amount = rows[i].getElementsByTagName('td')[amount_column].getAttribute('data-value')
        sum += (isNaN(price) || isNaN(amount)) ? 0 : parseFloat(price * amount);
    }
    return sum;
};

window.bops.setPriceTotal = function(amount, column) {
    $column_total = document.getElementById("total" + column);
    $column_total.setAttribute('data-value', amount);
    $column_total.innerHTML = "$" + amount.toFixed(2);
};