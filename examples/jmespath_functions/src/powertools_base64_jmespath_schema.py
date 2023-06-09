INPUT = {
    "$schema": "http://json-schema.org/draft-07/schema",
    "$id": "http://example.com/example.json",
    "type": "object",
    "title": "Sample order schema",
    "description": "The root schema comprises the entire JSON document.",
    "examples": [{"user_id": 123, "product_id": 1, "quantity": 2, "price": 10.40, "currency": "USD"}],
    "required": ["user_id", "product_id", "quantity", "price", "currency"],
    "properties": {
        "user_id": {
            "$id": "#/properties/user_id",
            "type": "integer",
            "title": "The unique identifier of the user",
            "examples": [123],
            "maxLength": 10,
        },
        "product_id": {
            "$id": "#/properties/product_id",
            "type": "integer",
            "title": "The unique identifier of the product",
            "examples": [1],
            "maxLength": 10,
        },
        "quantity": {
            "$id": "#/properties/quantity",
            "type": "integer",
            "title": "The quantity of the product",
            "examples": [2],
            "maxLength": 10,
        },
        "price": {
            "$id": "#/properties/price",
            "type": "number",
            "title": "The individual price of the product",
            "examples": [10.40],
            "maxLength": 10,
        },
        "currency": {
            "$id": "#/properties/currency",
            "type": "string",
            "title": "The currency",
            "examples": ["The currency of the order"],
            "maxLength": 100,
        },
    },
}
