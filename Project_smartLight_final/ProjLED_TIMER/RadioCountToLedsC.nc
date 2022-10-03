// $Id: RadioCountToLedsC.nc,v 1.7 2010-06-29 22:07:17 scipio Exp $

/*									tab:4
 * Copyright (c) 2000-2005 The Regents of the University  of California.  
 * All rights reserved.
 *o
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
 
#include "Timer.h"
#include "RadioCountToLeds.h"
 
/**
 * Implementation of the RadioCountToLeds application. RadioCountToLeds 
 * maintains a 4Hz counter, broadcasting its value in an AM packet 
 * every time it gets updated. A RadioCountToLeds node that hears a counter 
 * displays the bottom three bits on its LEDs. This application is a useful 
 * test to show that basic AM communication and timers work.
 *
 * @author Philip Levis
 * @date   June 6 2005
 */
 
 #include "printf.h"


module RadioCountToLedsC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer1;
    interface Timer<TMilli> as MilliTimer2;
    interface Timer<TMilli> as MilliTimer3;
    interface Timer<TMilli> as MilliTimer4;
    interface SplitControl as AMControl;
    interface Packet;
  }
}
implementation {

  message_t packet;

  bool locked ;
  nx_uint16_t j;
  nx_uint16_t z;
  //nx_uint16_t counter = 1;
  
 
  
  
  
  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      
      call MilliTimer1.startPeriodicAt(0,24000);
      call MilliTimer2.startPeriodicAt(8000,24000);
      call MilliTimer3.startPeriodicAt(4000,8000);
      call MilliTimer4.startPeriodicAt(16000,24000);
      
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }
  
  
  
  
  
  event void MilliTimer1.fired() {
    
   
  
  if(TOS_NODE_ID ==1){
      
      
      
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      
      rcm->sender = TOS_NODE_ID; 
      rcm->receiver[0] = 2;
      rcm->receiver[1] = 4;
      rcm->receiver[2] = 6;
      rcm->receiver[3] = 8; 
      rcm->receiver[4] = 10; 
      rcm->reset = FALSE;
      
      
      if (call AMSend.send(TOS_BCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS ) {
		//printf("The node that send is %u \n", TOS_NODE_ID);
		
	 locked = TRUE;
      }
      }
      
     
     
  
    
    }
  
  
  event void MilliTimer2.fired() {
    
  
  if(TOS_NODE_ID ==1){
      
      
      
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      
      rcm->sender = TOS_NODE_ID; 
      rcm->receiver[0] = 6;
      rcm->receiver[1] = 4;
      rcm->receiver[2] = 7;
      rcm->receiver[3] = 10; 
      rcm->receiver[4] = 0; 
      rcm->reset = FALSE;
      
      
      if (call AMSend.send(TOS_BCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS ) {
		//printf("The node that send is %u \n", TOS_NODE_ID);
		
	 locked = TRUE;
      }
      }
      
     
     
  
    
    }
  
  
  event void MilliTimer4.fired() {
    
  
  if(TOS_NODE_ID ==1){
      
      
      
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      
      rcm->sender = TOS_NODE_ID; 
      rcm->receiver[0] = 5;
      rcm->receiver[1] = 3;
      rcm->receiver[2] = 7;
      rcm->receiver[3] = 9; 
      rcm->receiver[4] = 0; 
      rcm->reset = FALSE;
      
      
      if (call AMSend.send(TOS_BCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS ) {
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("here  \n\n"  );
	 locked = TRUE;
      }
      }
      
     
     
  
    
    }
    
    event void MilliTimer3.fired() {
    
   
  
  if(TOS_NODE_ID ==1){
      
      
      
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      
      rcm->sender = TOS_NODE_ID; 
      rcm->receiver[0] = 0;
      rcm->receiver[1] = 0;
      rcm->receiver[2] = 0;
      rcm->receiver[3] = 0; 
      rcm->receiver[4] = 0;
      
      rcm->reset = TRUE;
      
      
      if (call AMSend.send(TOS_BCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS ) {
		//printf("The node that send is %u \n", TOS_NODE_ID);
		
	 locked = TRUE;
      }
      }
      
     
     
  
    
    }
   

  event message_t* Receive.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    
    if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
      
      
      if (TOS_NODE_ID == 2) {
      if(rcm->reset == TRUE){
        call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
      if(rcm->reset == TRUE){
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        
        r->reset = TRUE;
        if (call AMSend.send(3, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 2 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      else{
      for(j =0 ; j<5;j++){
        if(rcm->receiver[j] == 2){
        printf("Node 2 switching on.\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 3 || rcm->receiver[j] == 4){
      
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 2;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j];

      }
      r->reset = FALSE;
      
       
        
      if (call AMSend.send(3, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 3  \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      
      }}
      
      if (TOS_NODE_ID == 3) {
      if(rcm->reset == TRUE){
        call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
      if(rcm->reset == TRUE){
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        r->reset = TRUE;
        if (call AMSend.send(4, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 3 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      
      else{
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 3){
        printf("node 3 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 4){
      
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 3;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j];
      
      
      }
      r->reset = FALSE;
        
      if (call AMSend.send(4, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 4 \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      }
      }
      
      if (TOS_NODE_ID == 4) {
      if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
        else{
      
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 4){
        printf("node 4 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
        }
        }
        
        if (TOS_NODE_ID == 5) {
        if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
        if(rcm->reset == TRUE){
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        r->reset = TRUE;
        if (call AMSend.send(6, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 5 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      else{
      for(j =0 ; j<5;j++){
        if(rcm->receiver[j] == 5){
        printf("Node 5 switching on.\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 6 || rcm->receiver[j] == 7){
     
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 5;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j]; 
      }
      r->reset = FALSE;
        
      if (call AMSend.send(6, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 3  \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      }
      }
      
      if (TOS_NODE_ID == 6) {
      if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
       }
      if(rcm->reset == TRUE){
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        r->reset = TRUE;
        if (call AMSend.send(7, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 6 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      else{
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 6){
        printf("node 6 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 7){
      
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 6;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j];
      }
      r->reset = FALSE;
       
      if (call AMSend.send(7, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 7 \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      
      }
      }
      
      if (TOS_NODE_ID == 7) {
      if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        
		printf("the node 7 has been switched off  \n"  );
	 
      }
      else{
      
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 7){
        printf("node 7 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
        }
        }
        
    if (TOS_NODE_ID == 8) {
    if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
    if(rcm->reset == TRUE){
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        r->reset = TRUE;
        if (call AMSend.send(9, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 8 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      else{
      for(j =0 ; j<5;j++){
        if(rcm->receiver[j] == 8){
        printf("Node 8 switching on.\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 9 || rcm->receiver[j] == 10){
      
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 8;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j];
      }
      r->reset = FALSE;
      
      if (call AMSend.send(9, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 9  \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      }
      }
      
      if (TOS_NODE_ID == 9) {
      if(rcm->reset == TRUE){
        call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        }
      if(rcm->reset == TRUE){
        
        radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
        r->reset = TRUE;
        if (call AMSend.send(10, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the node 9 has been switched off  \n"  );
	 locked = TRUE;
	 
      }
      }
      else{
      
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 9){
        printf("node 3 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
      for(j =0 ; j<5;j++){
      if(rcm->receiver[j] == 10){
      
      radio_count_msg_t* r = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      
      r->sender = 9;
      for(j =0 ; j<5;j++){
      r->receiver[j] = rcm->receiver[j];
      
      }
      r->reset = FALSE;
         
      if (call AMSend.send(10, &packet, sizeof(radio_count_msg_t)) == SUCCESS ){
		//printf("The node that send is %u \n", TOS_NODE_ID);
		printf("the message has been inoltred towards 10 \n"  );
	 locked = TRUE;
	 
      }   
      
      }
      }
      
      }}
      
      if (TOS_NODE_ID == 10) {
      if(rcm->reset == TRUE){
      call Leds.led0Off();
        call Leds.led1Off();
        call Leds.led2Off();
        
		printf("the node 10 has been switched off  \n"  );
	 
      }
      else{
      
      for(z =0 ; z<5;z++){
        if(rcm->receiver[z] == 10){
        printf("node 10 switching on\n");
        call Leds.led0On();
        call Leds.led1On();
        call Leds.led2On();
        }
        
        }
        }
        }
      
      return bufPtr;
    }
  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      
      locked = FALSE;
  
    }
  }

}




