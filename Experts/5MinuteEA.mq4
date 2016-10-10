//+------------------------------------------------------------------+
//|                                                    5MinuteEA.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
  // EventSetTimer(60);
      
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
void start()
{   
//--- If there are more than 100 bars in the chart and the trade flow is free
   bool res = IsTradeAllowed();
   if(Bars<100 || res==false)
      return;
   if(CheckNewBar() == false)
      return;
   string direct = GetCurrentDirect();
//--- If the calculated lot size is in line with the current deposit amount
   if(CalculateCurrentOrders(Symbol())==0)
      CheckForOpen();   // start working
   else
      CheckForClose();  // otherwise, close positions
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Position opening function                                        |
//+------------------------------------------------------------------+
void CheckForOpen()
{
   double ma;
   int    res;
   //---- buy conditions
   if( m_tradeSigal == UP_CROSS ) //&& GetCurrentDirect() == UP
   {
         int ticket = OpenBuyOrder(Symbol(), LotsOptimized(), 5, MAGICMA,  "Buy Order");
         AddStopProflt(ticket, MarketInfo(Symbol(), MODE_BID)-InitingStopLoss*PipPoint(Symbol()), 0);
         log_out(StringFormat("%sUP_CROSS", "----"));
   }
   //---- sell conditions
   if( m_tradeSigal == DOWN_CROSS )//&& GetCurrentDirect() == DOWN
   {
         int ticket = OpenSellOrder(Symbol(), LotsOptimized(), 5, MAGICMA,  "Buy Order");
         AddStopProflt(ticket, MarketInfo(Symbol(), MODE_ASK)+InitingStopLoss*PipPoint(Symbol()), 0);
         log_out(StringFormat("%sDOWN_CROSS", "----"));
   }
   bNoHandingStop = true;
}
//+------------------------------------------------------------------+
//| Position closing function                                        |
//+------------------------------------------------------------------+
void CheckForClose()
{
   double ma;
   for(int i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
      if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
      //---- check order type 
      if(OrderType()==OP_BUY)
      {
         if(m_tradeSigal == DOWN_CROSS)  //GetCurrentDirect() == DOWN || 
            OrderClose(OrderTicket(), OrderLots(), Bid, 5, BuyColor);
      }
      if(OrderType()==OP_SELL)
      {
          if( m_tradeSigal == UP_CROSS)  //GetCurrentDirect() == UP ||
             OrderClose(OrderTicket(),OrderLots(),Ask,5,SellColor); 
      }
   }
   CheckTrailingStop(Symbol(), StopLoss, MinProfit, MAGICMA);
}