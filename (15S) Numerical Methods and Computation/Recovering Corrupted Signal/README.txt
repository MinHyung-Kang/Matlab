CS70_Long Assignment 5
Min Hyung (Daniel) Kang
--------------------------
We are given a corrupted signal and a filter which was used to generate the signal.
We will use three methods to estimate the original signal. 

We first set up the linear equation using matrices : 
Af = g, where A is the convolution matrix created with convmtx of matlab,
f is the original signal in vector form, and g is the corrupted signal in vector form.

(1)Least Squares
We know that f= inv(A'A)A'g. Hence we carry out the computation to get f.

(2)Steepest Descent
We first set up new matrices for the computation.
A_SD = A'A and b_SD = A'g.

Then we follow the usual steepest Descent method (described in the video) to compute the estimate for f.

(3)Conjugate Gradient
Again, we use the definition above.
We follow the usual Conjugate Gradient method (described in the video) to compute the estimate for f.

We plot each estimate as we compute, and for (2),(3) we plot for each iteration.
We iterate them until mean of error is less than 1e^-5 

(4) Assume we are now given the original signal f and the corrupted signal g.
Then we can set up a new matrix F as described in the video and set up a new system
Fh = g.
We use results from conjugate gradient for estimate of f and then use least squares to estimate h.
We compare the estimated h value with the actual value of h, and see that they are very similar.