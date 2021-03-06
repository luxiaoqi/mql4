//+------------------------------------------------------------------+
//|                                           五分钟动量交易系统.mq4 |
//+------------------------------------------------------------------+

extern double MAPeriod=20; //指数均线周期
extern double StopLossSpred = 20; //初始止损离均线的点数
extern double CloseSpred = 15; //后半仓止损离均线的点数
extern double Lots=0.2; //持仓,必须为偶数


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
  int start()
  {
    double MacdCurrent, MacdPrevious, Ma;
    int cnt, ticket, total;

    if(Bars<100)
    {
     Print("K线少于100根！");
     return(0);  
   }

   MacdCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   MacdPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,2);
   Ma=iMA(NULL,0,MAPeriod,0,MODE_EMA,PRICE_CLOSE,0);

   total=OrdersTotal();

  //开单检查
  if(total<1) //在没有持仓的情况下才能开新仓
  {
    // 检查资金
  	if(AccountFreeMargin()<(1000*Lots))
  	{
  		Print("资金不足： ", AccountFreeMargin());
  		return(0);  
  	}
    // 检查开多单的可能性
    if(MacdCurrent>0 && MacdPrevious<0 && Ask>Ma && Ask<=Ma+20*Point)  //MACD首红且汇价位于均线上20点内做多
    {
    	ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,3,Ma-StopLossSpred*Point,0,"lbs-buy",197658,0,Red);
    	if(ticket>0)
    	{
    		if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("开多单成功 : ",OrderOpenPrice());
    	}
    	else Print("开多单发生错误 : ",GetLastError()); 
    	return(0); 
    }
    // 检查开空单的可能性
    if(MacdCurrent<0 && MacdPrevious>0 && Bid<Ma && Bid>=Ma-20*Point) //MACD首绿且汇价位于均线下20点内做空
    {
    	ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,Ma+StopLossSpred*Point,0,"lbs-sell",197658,0,Green);
    	if(ticket>0)
    	{
    		if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("开空单成功 : ",OrderOpenPrice());
    	}
    	else Print("开空单发生错误 : ",GetLastError()); 
    	return(0); 
    }
    return(0);
  }

  //减仓及平仓检查   
  for(cnt=0;cnt<total;cnt++)
  {
    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
    if(OrderType()<=OP_SELL && OrderSymbol()==Symbol())  // check for symbol
    {
       if(OrderType()==OP_BUY)   // 如果有做多单存在
       {
          //多单减仓检查
       	if(Ask-OrderOpenPrice()>=OrderOpenPrice()-OrderStopLoss() && OrderOpenPrice()>OrderStopLoss() && OrderLots()==Lots)
       	{
              ticket=OrderClose(OrderTicket(),Lots/2,Ask,3,Violet); // 平掉一半仓位
              if(ticket>0)
              {
              	if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("多单减仓成功 : ",OrderOpenPrice());
              }
              else Print("多单减仓发生错误 : ",GetLastError());
              return(0); 
            }
            
          //修改后半仓位的止损价到盈亏平衡点
            if(Ask-OrderOpenPrice()>OrderOpenPrice()-OrderStopLoss() && OrderOpenPrice()>OrderStopLoss() && OrderLots()==Lots/2)
            {
             ticket=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Red); 
             if(ticket>0)
             {
              if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("多单盈亏平衡点修改成功 : ",OrderOpenPrice());
            }
            else Print("多单盈亏平衡点修改发生错误 : ",GetLastError());
            return(0); 
          }
          
          //根据行情发展修改剩余仓位的止损价到均线下15点
          if(Ma-CloseSpred*Point>OrderStopLoss() && OrderOpenPrice()<=OrderStopLoss() && OrderLots()==Lots/2)
          {
          	ticket=OrderModify(OrderTicket(),OrderOpenPrice(),Ma-CloseSpred*Point,OrderTakeProfit(),0,Red); 
          	if(ticket>0)
          	{
          		if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("多单止损修改成功 : ",OrderOpenPrice());
          	}
          	else Print("多单止损修改发生错误 : ",GetLastError());
          	return(0); 
          }  
        }
       else // 如果有做空单存在
       {
          //空单减仓检查
       	if(OrderOpenPrice()-Bid>OrderStopLoss()-OrderOpenPrice() && OrderOpenPrice()<OrderStopLoss() && OrderLots()==Lots)
       	{
              ticket=OrderClose(OrderTicket(),Lots/2,Ask,3,Violet); // 平掉一半仓位
              if(ticket>0)
              {
              	if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("空单减仓成功 : ",OrderOpenPrice());
              }
              else Print("空单减仓发生错误 : ",GetLastError());
              return(0); 
            }
            
          //修改后半仓位的止损价到盈亏平衡点
            if(OrderOpenPrice()-Bid>OrderStopLoss()-OrderOpenPrice() && OrderOpenPrice()<OrderStopLoss() && OrderLots()==Lots/2)
            {
             ticket=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Green); 
             if(ticket>0)
             {
              if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("空单盈亏平衡点修改成功 : ",OrderOpenPrice());
            }
            else Print("空单盈亏平衡点修改发生错误 : ",GetLastError());
            return(0); 
          }
          
          //根据行情发展修改剩余仓位的止损价到均线下15点
          if(Ma+CloseSpred*Point<OrderStopLoss() && OrderOpenPrice()>=OrderStopLoss() && OrderLots()==Lots/2)
          {
          	ticket=OrderModify(OrderTicket(),OrderOpenPrice(),Ma+CloseSpred*Point,OrderTakeProfit(),0,Green); 
          	if(ticket>0)
          	{
          		if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES)) Print("空单止损修改成功 : ",OrderOpenPrice());
          	}
          	else Print("空单止损修改发生错误 : ",GetLastError());
          	return(0); 
          } 
        }
      }
    }

    return(0);
 }
  // the end.