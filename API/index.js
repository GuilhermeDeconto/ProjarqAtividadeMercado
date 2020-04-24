const hapi = require('hapi');
const joi = require('joi');
const mongoose = require('mongoose');

const server = new hapi.Server({ "host": "localhost", "port": 9876 });

/* MongoDb connection */
mongoose.connect("mongodb://localhost/dbmarket", { useNewUrlParser: true, useUnifiedTopology: true });

const ProductModel = mongoose.model("product", {
    cliente: String,
    name: String,
    price: Number,
    madeby: String,
    category: String,
    quantity: Number
});

const MarketHoursModel = mongoose.model("market", {
    open: Boolean,
    time: Date
});

server.route({
    method: "GET",
    path: "/product",
    handler: async (request, resp) => {
        try {
            let product = await ProductModel.find().exec();
            var data = {
                status: "success",
                message: "Products retrieved successfully",
                product: product,
            }
            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "GET",
    path: "/market",
    handler: async (request, resp) => {
        try {
            let market = await MarketHoursModel.find().exec();
            var data = {
                status: "success",
                message: "Market worktime",
                market: market,
            }
            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "GET",
    path: "/product/{id}",
    handler: async (request, resp) => {
        try {
            let product = await ProductModel.findById(request.params.id).exec();
            var data = {
                status: "success",
                message: "Product retrieved successfully",
                product: product,
            }
            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "POST",
    path: "/product",
    options: {
        validate: {
            payload: {
                cliente: joi.string().required(),
                name: joi.string().required(),
                price: joi.number().required(),
                madeby: joi.string(),
                category: joi.string().required()
            },
            failAction: (request, resp, error) => {
                return error.isJoi ? resp.response(error.details[0]).takeover() : resp.response(error).takeover();
            }
        }
    },
    handler: async (request, resp) => {
        try {
            let product = new ProductModel(request.payload);
            let data = {
                message: 'New product created!',
                product: product
            }
            let result = await product.save();

            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "POST",
    path: "/market",
    options: {
        validate: {
            payload: {
                market: {
                    open: joi.boolean()
                    // time: joi.string().required()
                }
            },
            failAction: (request, resp, error) => {
                return error.isJoi ? resp.response(error.details[0]).takeover() : resp.response(error).takeover();
            }
        }
    },
    handler: async (request, resp) => {
        try {
            let market = new MarketHoursModel(request.payload.market);
            market.time = new Date();
            let data = {
                message: 'Market`s open',
                market: market
            }
            let result = await market.save();

            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});



server.route({
    method: "POST",
    path: "/productArray",
    // options: {
    //     validate: {
    //         payload: {
    //             produtos: [
    //                 {
    //                     cliente: joi.string().required(),
    //                     name: joi.string().required(),
    //                     price: joi.number().required(),
    //                     madeby: joi.string(),
    //                     category: joi.string().required()
    //                 }
    //             ]

    //         },
    //         failAction: (request, resp, error) => {
    //             return error.isJoi ? resp.response(error.details[0]).takeover() : resp.response(error).takeover();
    //         }
    //     }
    // },
    handler: async (request, resp) => {
        try {
            let products = []
            let totalPrice = 0
            for (let model of request.payload.produtos) {
                const product = new ProductModel(model)
                await product.save()
                totalPrice += product.price
                products.push(product)
            }
            let data = {
                message: 'New products created!',
                product: products,
                totalPrice: totalPrice
            }
            return resp.response(data);
        } catch (error) {
            console.log(error)
            return resp.response(error).code(500)
        }
    }
});

server.route({
    method: "PUT",
    options: {
        validate: {
            payload: {
                cliente: joi.string().optional(),
                name: joi.string().optional(),
                price: joi.number().optional(),
                madeby: joi.string().optional(),
                category: joi.string().optional()
            },
            failAction: (request, resp, error) => {
                return error.isJoi ? resp.response(error.details[0]).takeover() : resp.response(error).takeover();
            }
        }
    },
    path: "/product/{id}",
    handler: async (request, resp) => {
        try {
            let result = await ProductModel.findByIdAndUpdate(request.params.id, request.payload, { new: true });
            let data = {
                status: "success",
                message: "Product modified successfully",
                product: result
            }
            return resp.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "DELETE",
    path: "/product/{id}",
    handler: async (request, res) => {
        try {
            let result = await ProductModel.findByIdAndDelete(request.params.id);
            let data = {
                status: "success",
                message: "Product deleted successfully",
                product: result
            }
            return res.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "DELETE",
    path: "/product",
    handler: async (request, res) => {
        try {
            let result = await ProductModel.deleteMany();
            let data = {
                status: "success",
                message: "Product deleted successfully",
                product: result
            }
            return res.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});

server.route({
    method: "DELETE",
    path: "/market",
    handler: async (request, res) => {
        try {
            let result = await MarketHoursModel.deleteMany();
            let data = {
                status: "success",
                message: "Listings deleted successfully",
                market: result
            }
            return res.response(data);
        } catch (error) {
            return resp.response(error).code(500);
        }
    }
});


server.start(err => {
    if (err) {
        throw err;
    }

    console.log('Server started')
});