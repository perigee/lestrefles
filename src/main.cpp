//#include <boost/thread/thread.hpp>

//#include <boost/asio.hpp> 

#include <iostream>
#include <vector>
#include <algorithm>
#include <thread>
//#include <boost/move/move.hpp>


//#include<stdio.h>
#include<signal.h>
#include<unistd.h>




//void handler(const boost::system::error_code &ec) 
//{ 
//  std::cout << "5 s." << std::endl; 
//} 


void sig_handler(int signo)
  {
    if (signo == SIGINT)
      std::cout << "received SIGINT\n" << std::endl;

    exit(signo);


  }


 
void hello(int i)
{
  std::cout <<   "I'm a thread! "
	    << i << std::endl;
}
 
int main(int argc, char* argv[])
{
  
  std::vector<std::thread> workers;
  
  for (int i=0; i<8; ++i){
    auto th = std::thread(&hello, i);
    workers.push_back(std::move(th));

  }

  std::cout << "Hi from main\n" ;

  std::for_each(workers.begin(),workers.end(), [](std::thread & th){th.join();});
 

  // boost asio library test
  //  boost::asio::io_service io_service; 
  //  boost::asio::deadline_timer timer(io_service, boost::posix_time::seconds(5)); 
  //  timer.async_wait(handler); 
  //  io_service.run();


  // linux signal test
    if (signal(SIGINT, sig_handler) == SIG_ERR)
      std::cout << "\ncan't catch SIGINT\n" << std::endl;

    // A long long wait so that we can easily issue a signal to this process
    while(1) 
      sleep(1);

  

  return 0;
}
