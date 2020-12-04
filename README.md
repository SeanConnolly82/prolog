# prolog

Prolog assignment for MSc

The methodology I have used for Part 3 is:
	
    1. Basecase is if the blocks match the required order;
    2. Move stack 1 to 3;
    3. Move stack 2 to 3;
    4. Move blocks from stack 3 to stack 1 if they match the required stack 1, otherwise move to stack 2;
    5. Move stack 3 to stack 2;
    6. Move stack 2 to stack 1;
    7. Move blocks from stack 1 to stack 2 if they match the required stack 2, otherwise move to stack 3;
    8. Move stack 1 to 3;
    9. Move stack 2 to 3;
    10. Move blocks from stack 3 to stack 1 if they match the required stack 1, otherwise move to stack 2;
    11. Go to step 1 and repeat.

    I have successfully tested on the following scenarios:

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[a,b,c],[d,e,f],[g,h]]

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[a,d,f],[e,h,b],[c,g]]

    Input:  [[b,c,f],[a,d,g],[h,e]]
    Order:  [[f,a,b],[c,d,g],[e,h]]

