#define MAX_PHILOSOPHERS 5
#define left forks[my_id]
#define right forks[(my_id+1)%MAX_PHILOSOPHERS]

mtype={fork}
chan forks[MAX_PHILOSOPHERS] = [1] of {bit};

proctype philosopher(int my_id)
{
	do
		::left?fork -> /* try to get left fork */
			right?fork; /* try to get right fork */
			/* eat... */
			left!fork; right!fork /* release forks */
			/* meditation... */
	od
}

init
{
	byte philosophers=MAX_PHILOSOPHERS;
	atomic {
		do
			::philosophers>0 ->
				philosophers--;
				run philosopher(philosophers);
				forks[philosophers]!fork
			::philosophers==0 ->
				break
		od
	}
}
