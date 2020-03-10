/**
 * @file GridTableJS
 * @author Tadeo Baljevic
 * @version 1.0
 * */


window.gridtablejs = (function () {
	
	/**
	 * The library constructor.
	 * @constructor
	 */
	function GridTableJS () {
		this.gridTables = [];
	};
	
	GridTableJS.prototype = {
		
		/**
		 * A wrapper for the instantiation of GridTableManager objects
		 * 
		 * @param {String} parentElemId: The id of the parent element.
		 */
		createTable: function (parentElemId) {
			parentElement = document.getElementById(parentElemId);
			
			// Determine if the provided parent element ID is valid
			if (parentElement) {
				gridTable = new GridTableManager(parentElemId);
				this.gridTables.push(gridTable);
				return gridTable;
			} else {
				error(`Invalid parent element id: '${parentElemId}'`);
				return undefined;
			}
		}
		
	};
	
	
	/**
	 * The definition of a grid table.
	 * @constructor
	 * 
	 * @param {String} parentElemId - The DOM ID of the parent element to which this table will be attached.
	 */
	function GridTableManager (parentElemId) {
		this.parentElemId = parentElemId;
		this.cells = [];
		this.usageMatrix = new UsageMatrix();
	}

	GridTableManager.prototype = {
		
		/**
		 * Manages the addition of a cell.
		 * 
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The column.
		 * @param {String} content: The contents of the cell.
		 * @param {Object} customAttributes: Any HTML attributes to be set.
		 * @param {String} domTag: The HTML DOM tag for the cell.
		 * 
		 * @returns {GridTableCell}
		 */
		addCell: function (row, column, content, customAttributes, domTag) {
			cell = new GridTableCell(
					row = row,
					column = column,
					content = content,
					customAttributes = customAttributes,
					domTag = domTag
				);
			
			success = this.usageMatrix.populate(
							id = this.cells.length,
							row = row,
							column = column,
							colspan = cell.colspan,
							rowspan = cell.rowspan
						);
			
			if (success) {
				this.cells.push(cell);
				return cell;
			} else {
				warn(`Unable to insert the following cell due to clashes:\nrow: ${cell.row}\ncolumn: ${cell.column}\ncell content: ${cell.content}`);
				return false;
			}
		},
		
		/**
		 * Manages the addition of multiple cells.
		 * 
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The initial column from which to begin inserting cells.
		 * @param {Array} cellContents: An array of strings representing the contents of the cells.
		 * @param {Object} customAttributes: HTML attributes to be set on all of the cells being inserted.
		 * @param {String} domTag: The HTML DOM tag for all of the cells being inserted.
		 * 
		 * @returns {Array} array of inserted cells.
		 */
		addCells: function (row, column, cellContents, customAttributes, domTag) {
			cells = [];
			columnLocation = column;
			
			for (contentIndex in cellContents) {
				cellContent = cellContents[contentIndex];
				cell = this.addCell(
						row = row,
						column = columnLocation,
						content = cellContent,
						customAttributes = customAttributes,
						domTag = domTag
					)
				
				cells.push(cell);
				
				columnLocation += cell.colspan;
			}
			return cells;
		},
		
		/**
		 * Generates the inner-content for the resultant table.
		 * 
		 * @returns {String} Table contents in a string format.
		 */
		_generatedRenderedTableContents: function () {
			html = "";
			
			insertionChart = this.usageMatrix.createInsertionChart();
			
			for (row = 0; row < insertionChart.length; row++) {
				html += "<tr>";
				for (column = 0; column < insertionChart[row].length; column++) {
					cellId = insertionChart[row][column];
					
					if (cellId == null) {
						html += "<td></td>";
					} else {
						// Get the cell that is being referred to and have it rendered.
						cell = this.cells[cellId];
						html += cell.render();
					}
				}
				html += "</tr>";
			}
			return html;
		},
		
		/**
		 * Renders the table to the parent element provided at initialisation.
		 */
		render: function () {
			parent = document.getElementById(this.parentElemId);
			parent.innerHTML = "";
			
			table = document.createElement("table");
			table.innerHTML = this._generatedRenderedTableContents(this.cells.length);
			
			parent.appendChild(table);
		}
	}


	/**
	 * Defines a usable area in a two-dimensional chart.
	 * @constructor
	 */
	function UsageMatrix () {
		this.usageChart = [];
		
		this.maxColumns = 0;
	}

	UsageMatrix.prototype = {
		
		/**
		 * Determines whether a given row exists.
		 * 
		 * @param {Integer} row: The row being checked.
		 * 
		 * @returns {Boolean}
		 */
		rowExists: function (row) {
			return row < this.usageChart.length;
		},
		
		/**
		 * Determines whether a cell is populated or not
		 * 
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The column.
		 * 
		 * @returns {Boolean}
		 */
		cellIsPopulated: function (row, column) {
			if (this.rowExists(row)) {
				if (column < this.usageChart[row].length) {
					return true;
				}
			}
			return false;
		},
		
		/**
		 * Returns the ID of the cell at a given grid location
		 * 
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The column.
		 * 
		 * @returns {Integer} The ID of the cell (or an undefined value).
		 */
		getCellValue: function (row, column) {
			if (this.cellIsPopulated(row, column)) {
				return this.usageChart[row][column];
			} else {
				return undefined;
			}
		},
		
		/**
		 * Checks whether a region in the usageChart is free for insertion.
		 * 
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The column.
		 * @param {Integer} colspan: The number of columns the region should span.
		 * @param {Integer} rowspan: The number of rows the region should span.
		 * 
		 * @returns {Boolean}
		 */
		canPopulate: function (row, column, colspan, rowspan) {
			// Check for a quick exit
			if (row > this.usageChart.length) {
				return true;
			}

			for (r = row; r < row+rowspan; r++) {
				for (c = column; c < column+colspan; c++) {
					if (this.getCellValue(r, c) !== undefined) {
						return false;
					}
				}
			}
			return true;
		},
		
		/**
		 * Partially fills the usageChart with rows and columns as required.
		 * 
		 * @param {Integer} rowCount: The minimum amount of rows there should be (more is fine).
		 * @param {Integer} columnCount: The minimum amount of columns in the final row (more is fine).
		 */
		addRowsAndColumns: function (rowCount, columnCount) {
			if (rowCount >= this.usageChart.length) {
				for (var r = this.usageChart.length; r <= rowCount; r++) {
					this.usageChart.push([]);
				}
			}
			
			if (columnCount > this.maxColumns) {
				this.maxColumns = columnCount;
			}
			if (this.rowExists(rowCount) && columnCount > this.usageChart[rowCount].length) {
				for (var c = this.usageChart[rowCount].length; c <= columnCount; c++) {
					this.usageChart[rowCount].push(undefined);
				}
			}
		},
		
		/**
		 * Populates a particular grid location in the usageChart.
		 * 
		 * @param {Integer} id: The ID of the cell being inserted (for later lookup).
		 * @param {Integer} row: The row.
		 * @param {Integer} column: The column.
		 */
		populateCell: function (id, row, column) {
			this.addRowsAndColumns(
					rowCount = row,
					columnCount = column
				);
			this.usageChart[row][column] = id;
		},
		
		/**
		 * Populates a region in the usageChart.
		 * 
		 * @param {Integer} id: The ID of the cell being inserted.
		 * @param {Integer} row: The top-most row for the cell (the cell may have a rowspan).
		 * @param {Integer} column: The left-most column for the cell (the cell may have a colspan).
		 * @param {Integer} colspan: The number of columns the cell spans.
		 * @param {Integer} rowspan: The number of rows the cell spans.
		 * 
		 * @returns {Boolean} The success or failure of the cell population.
		 */
		populate: function (id, row, column, colspan, rowspan) {
			if (this.canPopulate(row, column, colspan, rowspan)) {
				for (var r = 0; r < rowspan; r++) {
					rowPosition = row + r;
					
					for (var c = 0; c < colspan; c++) {
						columnPosition = column + c;
						
						this.populateCell(id, rowPosition, columnPosition);
					}
				}
				return true;
			} else {
				return false;
			}
		},
		
		/**
		 * Creates an insertion chart to simplify the rendering of the table.
		 * 
		 * @returns {Array} The two-dimensional array representing the initial grid-reference
		 * 		at which cells will be inserted.
		 */
		createInsertionChart: function () {
			
			usedIds = [];
			insertionChart = [];
			
			// Iterate over all the values in the usageChart and determine whether
			// they should be pushed to the insertionChart
			for (row = 0; row < this.usageChart.length; row++) {
				insertionChart.push([]);
				
				for (column = 0; column < this.usageChart[row].length; column++) {
					gridTableCellId = this.usageChart[row][column];
					
					if (gridTableCellId == null || gridTableCellId == -1) {
						insertionChart[row].push(undefined);
					} else {
						if (usedIds.indexOf(gridTableCellId) == -1) {
							usedIds.push(gridTableCellId);
							insertionChart[row].push(gridTableCellId);
						}
					}
				}
				
				emptyColumnsToInsert = this.maxColumns - this.usageChart[row].length;
				
				for (i = 0; i <= emptyColumnsToInsert; i++) {
					insertionChart[row].push(undefined);
				}
			}
			
			return insertionChart;
		}
	}
	
	
	/**
	 * Represents a cell.
	 * @constructor
	 * 
	 * @param {Integer} row: The row the cell will be inserted into.
	 * @param {Integer} column: The column the cell be inserted into.
	 * @param {String} content: The content of the cell.
	 * @param {Object} customAttributes: The key-value pairs that will be applied to the
	 * 			resultant cell. (e.g. {rowSpan: 3, class: "my-class"})
	 * @param {String} domTag: The html tag that will be used for the cell ("th"/"td").
	 */
	function GridTableCell (row, column, content, customAttributes = {}, domTag = "td") {
		var validDomTags = ["td", "th"];
		
		this.row = row;
		this.column = column;
		this.content = content;
		this.customAttributes = customAttributes;
		
		if (validDomTags.indexOf(domTag) > -1) {
			this.domTag = domTag;
		} else {
			this.domTag = "td";
		}

		// For simplicity of calculation, we pull the row- and colSpans from the 
		// "customAttributes" variable
		this.rowspan = 1;
		this.colspan = 1;
		if ("rowspan" in this.customAttributes) {
			this.rowspan = this.customAttributes["rowspan"];
		}
		if ("colspan" in this.customAttributes) {
			this.colspan = this.customAttributes["colspan"];
		}
	}

	GridTableCell.prototype = {
		
		/**
		 * Creates an HTML-formatted representation of the cell.
		 * 
		 * @returns {String} The html-formatted cell.
		 */
		render: function () {
			var attributes = "";
			for (key in this.customAttributes) {
				attributes += ` ${key}="${this.customAttributes[key]}"`
			}
			return `<${this.domTag} ${attributes}>${this.content}</${this.domTag}>`
		}
	}
	
	
	/** Writes an error message to the console. */
	function error (message) {
		console.error("GridTableJS:: " + message);
	}
	
	
	/** Writes a warning message to the console */
	function warn (message) {
		console.warn("GridTableJS:: " + message);
	}
	
	
	var gridtablejs = new GridTableJS();
	return gridtablejs;
}());