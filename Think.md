# Think.js

```js
const Think = (() => {

    /*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PERCEPTRON :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
    class Perceptron {
        constructor() {
            this.weights = [];
            this.arr = [];
        }

        fill() {
            this.weights.length = 2; // 2
            this.weights.fill(Math.random());

            if (this.weights.length == 2) {
                this.weights.push(1);
            }
        }

        train(data) { // [[0, 1], 1]
            const res = this.calc(data[0]); // inputs data 0 ... expected data 1
            this.arr.push(data)
            this.weights.forEach((el, i) => {
                const input = (i == data[0].length) ? 1 : data[0][i];
                let diff = data[1] - res;
                this.weights[i] += diff * input * 0.1;
            });

        }

        calc(inputs) {
            let res = 0;
            inputs.forEach((el, i) => res += this.weights[i] * inputs[i]);
            res += this.weights[this.weights.length - 1]; // bias, different each time
            return this.sigmoid(res);
        }


        retrain() {
            this.arr.forEach(e => this.train(this.arr.shift()));
        }

        learn() {
            for (let i = 0; i < 1000; i++) {
                this.retrain();
            }
        }

        sigmoid(x) {
            return 1 / (1 + Math.exp(-x));
        }
    }



    /*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: NEURAL NETWORK :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
    const sigmoid = x => 1 / (1 + Math.exp(-x)); // maps any input into value between 0 and 1
    const sgrad = x => sigmoid(x) * (1 - sigmoid(x)); // val * (1 - val)


    class N {
        constructor(ni) {
            this.weights = [];
            this.weights.length = ni;
            this.weights.fill(Math.random());
        }

        forward(inputs) {
            this.inputs = inputs;
            this.sum = 0;
            this.weights.forEach((el, i) => this.sum += this.weights[i] * this.inputs[i]);
            return sigmoid(this.sum);
        }

        backward(error) {
            this.error = error;
            return this.weights.map(w => w * error).slice(1); // remove bias
        }

        /* adjusting weights: make adjustment proportional to the size of error "sigmoid gradient" ensures the we adjust just a little bit
        pass "this.sum" from "forward()" into sigmoid gradient (sgrad), adjust weights by substracting deltas */
        update() {
            const deltas = this.inputs.map(input => input * sgrad(this.sum) * this.error);
            this.weights.forEach((el, i) => this.weights[i] = this.weights[i] - deltas[i]);
        }
    }


    //-------------------------
    class Layer {
        constructor(len, inputs) {
            this.neurons = [];
            this.neurons.length = len;
            this.neurons.fill(new N(inputs));
        }

        forward(inputs) {
            return this.neurons.map(n => n.forward(inputs));

        }

        backward(errors) {
            return this.neurons.map((n, i) => n.backward(errors[i])).reduce((a, b) => a + b); // pass each error backwards and get weighted sum
        }

        update(data) {
            this.neurons.forEach(n => n.update());
        }
    }




    //-------------------------
    class Network {
        constructor() {
            this.layers = [new Layer(3, 3), new Layer(1, 4)];
        }

        /*
        "ourdata" is [0, 1] is "first", that gets passed into concat so: Layer {n: Array(1)}.forward([1,0,1]) 
        the last value is returned (thats why we use reduce) we are training and returning, but we only care about returned value after the loop finishes  */
        forward(first) {
            return this.layers.reduce((ourdata, layer) => layer.forward([1].concat(ourdata)), first);
        }

        learn(data) {

            for (let it = 0; it < 1000; it++) {

                // fill err array with (result from network - desired output), and update the connection weights between nodes
                const res = this.forward(data[0]);
                let err = [];
                res.forEach((el, index) => err.push(res[index] - data[1]));

                // backpropagation , send err array back
                this.layers.reverse().reduce((error, layer) => layer.backward(error), err);
                this.layers.reverse(); // reverse back

                // update the connection weights 
                this.layers.forEach(l => l.update());
            }


            // add bias, and get our result
            const output = this.forward(data[0]);
            return output;
        }

    }




    /*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: LINEAR REGRESSION :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/


    class P {
        constructor(x, y) {
            this.x = x;
            this.y = y;
        }
    }


    class LR {
        constructor(selector) {
            this.selector = selector;
            this.el = null;
            this.points = [];
        }

        init() {
            this.el = document.querySelector(this.selector);
            this.ctx = this.el.getContext("2d");
            this.el.addEventListener("click", e => {
                let x = e.clientX - this.el.offsetLeft; // top left corner.... coord are [0, 0]
                let y = e.clientY - this.el.offsetTop;
                this.points.push(new P(x, y));
                this.draw();
            });
        }

        draw() {
            let ctx = this.ctx,
                points = this.points;
            ctx.clearRect(0, 0, 400, 400); // this.el.width
            ctx.fillStyle = "#3498db";

            points.forEach((el, i) => {
                ctx.beginPath();
                ctx.arc(points[i].x, points[i].y, 2, 0, 2 * Math.PI);
                ctx.fill();
            });

            let f = this.linreg(points);
            let y = this.line(f.g, f.i);
            ctx.strokeStyle = "#1abc9c";
            ctx.beginPath();
            ctx.moveTo(0, f.i);
            ctx.lineTo(400, y); // 400 - line across entire width of the element 
            ctx.stroke();
        }

        line(g, i) {
            return 400 * g + i; // m*x + b => 400 * gradient + intercept
        }


        linreg(points) {

            let x = 0,
                b = 0;

            let meanX = points.map(a => a.x).reduce((a, b) => a + b) / points.length;
            let meanY = points.map(a => a.y).reduce((a, b) => a + b) / points.length;

            points.forEach((val, i) => {
                x += (points[i].x - meanX) * (points[i].y - meanY); // current "x" point - avg "x" point value * (same for "y")
                b += (points[i].x - meanX) * (points[i].x - meanX); // each "x" point - avg, squared
            });

            let gradient = x / b;

            return {
                g: gradient, // gradient
                i: meanY - gradient * meanX // intercept with y axis
            }
        }

    }



    /*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: K MEANS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/

    class Means {
        constructor(selector) {
            this.selector = selector;
            this.points = []; // filled with our input
            this.means = [];
            this.assigned = {};
        }


        init(points) {
            this.el = document.querySelector(this.selector);
            this.ctx = this.el.getContext("2d");
            this.points = points;
        }


        /* --------------INIT MEANS-------------- init k means (2 in this case) within range ----------------------------
        we use size of our canvas, but we could get eg. xm range like this xm = Math.max(...points.map(e => e.x));, subtract xn Math.Min*/
        initMeans(k = 2) {
            this.means.length = k;
            this.means.fill(0)
            this.k = k;

            this.means.forEach((el, i) => {
                let cand = new P(400 * Math.random(), 400 * Math.random()); // this.el.width
                this.means.push(cand);
            });

            this.means = this.means.slice(k); // [0, 0, Point, Point] remove 2 zeros
            return this.means;
        }




        /* --------------ASSIGN-------------- assign each point to either first or second centroid (centrs[0] or centrs[1])  ---------------------------- */
        assign(centrs) {
            let distances = [],
                sum = 0;

            // 2 random centroid candidates
            let first = centrs[0];
            let second = centrs[1];

            // get each points positive distance from both centroids and fill-in distances array with objects with those data
            points.forEach((val, i) => {

                let point = points[i];
                let distanceZero = Math.sqrt(Math.pow((point.x - first.x), 2) + Math.pow((point.y - first.y), 2));
                let distanceOne = Math.sqrt(Math.pow((point.x - second.x), 2) + Math.pow((point.y - second.y), 2));

                let res = {
                    pointIndex: i,
                    zeroDist: distanceZero,
                    oneDist: distanceOne,
                    assignTo: 0 // index of centroid we assign to
                }

                distances[i] = res;
            });

            // change assignTo property according to distance from the centroid
            distances.forEach((el, i) => {
                if (distances[i].zeroDist < distances[i].oneDist) { // closer to zero
                    distances[i].assignTo = 0
                } else {
                    distances[i].assignTo = 1;
                }
            });

            // clear the canvas so we don´t have multiple points (btw. you can plot centers[0] and centers[1] points)
            this.ctx.clearRect(0, 0, 400, 400);
            this.plot();



            // --------------------------------------------------------- final data array
            let data = [];

            // firstly push points assigned to means[0] point to data
            let clustero = distances.filter(el => el.assignTo === 0);
            clustero.forEach((el, i) => {

                let point = points[clustero[i].pointIndex];

                this.ctx.fillStyle = "orange";
                this.ctx.beginPath();
                this.ctx.arc(point.x, point.y, 4, 0, 2 * Math.PI);
                this.ctx.fill();
                data.push(point)
            });

            // second push points assigned to means[0] point to data
            let clusterb = distances.filter(el => el.assignTo === 1);
            clusterb.forEach((el, i) => {

                let point = points[clusterb[i].pointIndex];

                this.ctx.fillStyle = "blue";
                this.ctx.beginPath();
                this.ctx.arc(point.x, point.y, 4, 0, 2 * Math.PI);
                this.ctx.fill();
                data.push(point);
            });


            // get both cluster centers using "clusterMean()" and draw it
            let half = this.clusterMean(data).half;
            this.ctx.fillStyle = "red";
            this.ctx.beginPath();
            this.ctx.arc(half.x, half.y, 6, 0, 2 * Math.PI);
            this.ctx.fill();

            let end = this.clusterMean(data).end;
            this.ctx.fillStyle = "red";
            this.ctx.beginPath();
            this.ctx.arc(end.x, end.y, 6, 0, 2 * Math.PI);
            this.ctx.fill();

            return {
                dist: distances,
                halfMean: half,
                endMean: end
            }

        }



        /* --------------CLUSTER MEAN-------------- get means of point in first and in 2nd half of arrays ---------------------------- */
        clusterMean(data) {
            let half = data.slice(0, Math.floor(data.length / 2)); // first half of distances array
            const halfMeanX = half.map(p => p.x).reduce((a, b) => a + b) / half.length;
            const halfMeanY = half.map(p => p.y).reduce((a, b) => a + b) / half.length;

            let end = data.slice(Math.floor(data.length / 2), data.length); // second half of distances array
            const endMeanX = end.map(p => p.x).reduce((a, b) => a + b) / end.length;
            const endMeanY = end.map(p => p.y).reduce((a, b) => a + b) / end.length;

            const halfMean = {
                x: halfMeanX,
                y: halfMeanY
            }

            const endMean = {
                x: endMeanX,
                y: endMeanY
            }

            return {
                half: halfMean,
                end: endMean
            }

        }

        /* --------------PLOT-------------- plot points from array into our canvas ---------------------------- */
        plot() {

            let points = this.points,
                ctx = this.ctx;
            ctx.fillStyle = "#000";

            points.forEach((el, i) => {
                ctx.beginPath();
                ctx.arc(points[i].x, points[i].y, 4, 0, Math.PI * 2);
                ctx.fill();
            });
        }

        /* --------------TRY
        1) assign data points to centroid[0] or centroid[0] according to distance and get their center
        2) assign all points to that new center position and get their mean position again */
        try () {

            let means = this.initMeans();
            this.assign(means);
            let res = this.assign(means);

            // this is where the magic happens -> one iteration of K-Means algorithm :D
            setTimeout(() => {
                let half = res.halfMean;
                let end = res.endMean;
                this.assign([half, end]);
            }, 2000);
        }


    }



    /*------------------------------------------------------------------------------------------------------*/
    const XOR = (data) => {
        const p = new Perceptron();
        p.fill();
        p.train(data);
        p.learn();
        let res = p.calc(data[0]);
        return res;
    }

    const Net = (data) => {
        const n = new Network();
        const res = n.learn(data);
        return res;
    }

    const Regression = (selector) => {
        let r = new LR(selector);
        r.init();
    }

    const KMeans = (selector, points) => {
        let m = new Means(selector);
        m.init(points);
        m.try();
    }

    return {
        XOR,
        Net,
        Regression,
        KMeans
    }

})();


let res = Think.Net([[0, 1], 0]);
console.log(res);

```
