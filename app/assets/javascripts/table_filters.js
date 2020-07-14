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
        columns = [4];
        for (column = 0; column < columns.length; column++) {
            total = calculateTotal($rows, $filteredRows, column);
            setTotal(total, 4);
        }

        if ($filteredRows.length === $rows.length) {
            $total_row.hide();
            $table.find('tbody').prepend($('<tr class="no-result text-center"><td colspan="'+ $table.find('.filters th').length +'">No Result Found.</td></tr>'));
        } else {
            $total_row.show();
        }
    });
});

function calculateTotal(rows, filtered_rows) {
    column = 4;
    row_sum = sumColumn(rows, column);
    filtered_row_sum = sumColumn(filtered_rows, column);
    return row_sum - filtered_row_sum
}

function setTotal(amount, column) {
    document.getElementById("data" + column).innerHTML = amount;
}

function sumColumn(rows, column) {
    sum = 0;
    for (i = 0; i < rows.length; i++) {
        var val = rows[i].getElementsByTagName('td')[column].innerHTML;
        sum += isNaN(val) ? 0 : parseInt(val);
    }
    return sum;
}