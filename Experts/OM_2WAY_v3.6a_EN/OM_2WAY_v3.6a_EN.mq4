#property copyright ""
#property link      ""
#include <stderror.mqh>
#include <stdlib.mqh>

//===================================================================================================================================================
extern string EAName             = "OM_2WAY_v3.6a";
//===================================================================================================================================================
extern int MagicNumberBuy        = 123456789;   
extern int MagicNumberSell       = 987654321;   

extern string s1                 = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>";
extern bool   OnScreenInfo       = true;   // Show info on chart
extern bool   ShowClock          = false;  // Show time on chart
extern bool   DrawAveragePrice   = false;  // Draw average price line
extern bool   DualTrade          = false;  // Allow buy and sell
extern bool   NewTradeBuy        = true;   // Allow buys
extern bool   NewTradeSell       = true;   // Allow sells 

extern string s4                 = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>";
extern string s5                 = ">>> Pips Settings"; 
extern bool   CheckNewBar        = true;   // on new bar
extern int    MaxTrades          = 30;     // Max number of open orders
extern double PipStep            = 25.0;   // Step between pips
extern double PipStepExponent    = 1.0;    // Exponent
extern int    StaticTakeProfit   = 15;     // Fixed Take Profit

extern string s6                 = ">>> Close order settings";
extern double ProfitPersent      = 30;     // Percent to close(10...50) // percent to close
extern double SecondProfitPersent = 50;    // Percent to close previous last order 

extern string s8                 = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>";
extern string s9                 = ">>> Calculating lot size";
extern double StartLot           = 0.2;    // Initial lot size
extern double LotIncrement       = 0.1;    // Increment lot to add  
extern double MaxLot             = 30;     // Maximum lot size
extern bool   UseAutoLot         = false;  // Use Auto-lot ... % deposit
extern double AutoLot            = 0.5;    // Percent - calculate lot size from equity
extern double AutoLotIncrement   = 0.3;    // Percent of lot to add

extern string s10                = ">>>>>>>>>>>>>>>>>>>>>>>>>>>>";
extern string s11                = ">>> Enter opposite MA"; 
extern int    iMA_Period         = 700;
extern int    iMA_OpenDistance   = 60;


//===================================================================================================================================================
int i = 0;
int TimePrev = 0;
int vDigits;
int OrderSended = 0;
int TotalBuyOrders = 0, TotalSellOrders = 0;
int Lpos, Lpos1, Cpos;

double Spread;
double mPipStep;
double vPoint;
double PriceTarget, AveragePrice, LastBuyPrice, LastSellPrice;
double BuySummLot,SellSummLot,TotalProfitBuy,TotalProfitSell;
double BLot, SLot;
double Cprofit, Lprofit, Lprofit1, PrcCL;

string LastOrderComment = "";
string BComment, SComment;

//===================================================================================================================================================
//===================================================================================================================================================
int init()
{
  vPoint  = Point;
  vDigits = Digits;
  TimePrev = Time[0];
  Spread = NormalizeDouble(MarketInfo(Symbol(), MODE_SPREAD),vDigits)*vPoint;
  
  // 5 digit broker
  int DcD = 1;
  if((vDigits == 5)||(vDigits == 3)) DcD = 10;   
  PipStep           *= DcD;
  StaticTakeProfit  *= DcD;
  iMA_OpenDistance  *= DcD;
  
  if(OnScreenInfo) DrawInfo();
  
  return(0);
}

//===================================================================================================================================================
//===================================================================================================================================================
int deinit()
{
  ObjectDelete("CurrTime");
  ObjectDelete("BuyZeroLevel");
  ObjectDelete("BuyAveragePrice");
  ObjectDelete("SellZeroLevel");
  ObjectDelete("SellAveragePrice");

  return(0);
}

//===================================================================================================================================================
//===================================================================================================================================================
int start()
{
  // clock
  if(ShowClock) ShowCurrentTime();

  // info
  if(OnScreenInfo) DrawInfo();

  // checking new bar
  if(TimePrev == Time[0] && CheckNewBar == true) return(0);   

  CheckOverlapping();  

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  // New buy orders
  TotalBuyOrders = CountOfOrders(MagicNumberBuy);
  if(TotalBuyOrders > 0 && TotalBuyOrders < MaxTrades)
  {
    OrderSended = -1;
    LastBuyPrice = FindLastOrderParameter(MagicNumberBuy, "price");

    if(LastBuyPrice - Ask >= GetPipstepForStep(TotalBuyOrders + 1) * vPoint)
    {
      BLot   = GetLotForStep(MagicNumberBuy, TotalBuyOrders);
      BComment = StringSubstr(LastOrderComment, 0, StringFind(LastOrderComment, "|", 0)) + "|";
      OrderSended = SendMarketOrder(OP_BUY, BLot, 0, 0, MagicNumberBuy, BComment);
    }
  }
  
  
  //-------------------------------------------------------------------------------------------------------------------------------------------------
  // New sell orders
  TotalSellOrders = CountOfOrders(MagicNumberSell);
  if(TotalSellOrders > 0 && TotalSellOrders < MaxTrades)
  {
    OrderSended = -1;
    LastSellPrice = FindLastOrderParameter(MagicNumberSell, "price");

    if (Bid - LastSellPrice >= GetPipstepForStep(TotalSellOrders + 1) * vPoint) 
    {
      SLot   = GetLotForStep(MagicNumberSell, TotalSellOrders);
      SComment = StringSubstr(LastOrderComment, 0, StringFind(LastOrderComment, "|", 0)) + "|";
      OrderSended = SendMarketOrder(OP_SELL, SLot, 0, 0, MagicNumberSell, SComment);
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //Move Take Profit
  CheckTakeProfit();

  //-------------------------------------------------------------------------------------------------------------------------------------------------
  //Check new bar...first orders of the series only according to new bars

  if (TimePrev == Time[0]) return(0);   
  TimePrev = Time[0];

  int TradeSignal = GetSignal();
  
  // New buy series ...
  if (TotalBuyOrders == 0 && NewTradeBuy && TradeSignal > 0 && (DualTrade == true || TotalSellOrders == 0))
    SendMarketOrder(OP_BUY, GetStartLot(), StaticTakeProfit, 0, MagicNumberBuy, TimeCurrent() + "|");     
  
  // New sell series ...
  if (TotalSellOrders == 0 && NewTradeSell && TradeSignal < 0 && (DualTrade == true || TotalBuyOrders == 0))
    SendMarketOrder(OP_SELL, GetStartLot(), StaticTakeProfit, 0, MagicNumberSell, TimeCurrent() + "|");     

  return(0);
}

//===================================================================================================================================================
//===================================================================================================================================================
void CheckTakeProfit()
{
  //BUY
  TotalBuyOrders = CountOfOrders(MagicNumberBuy);
  
  PriceTarget = 0;
  AveragePrice = 0;
  if(TotalBuyOrders > 0) 
  {
    PriceTarget = FindFirstOrderParameter(MagicNumberBuy, "price") + StaticTakeProfit*vPoint;
    AveragePrice = CalculateAveragePrice(MagicNumberBuy);
  }

  for (i = 0; i < OrdersTotal(); i++) 
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumberBuy)
        if (NormalizeDouble(OrderTakeProfit(),vDigits) != NormalizeDouble(PriceTarget,vDigits)) ModifyTakeProfit(PriceTarget);

  if(DrawAveragePrice == true)
  {
    if(AveragePrice == 0)
    {
      if(ObjectFind("BuyZeroLevel") != -1) ObjectDelete("BuyZeroLevel");
      if(ObjectFind("BuyAveragePrice") != -1) ObjectDelete("BuyAveragePrice");
    }
    else
    {
      if(ObjectFind("BuyZeroLevel") == -1) 
      {
        ObjectCreate("BuyZeroLevel",OBJ_HLINE, 0, 0, AveragePrice);
        ObjectSet("BuyZeroLevel", OBJPROP_COLOR, Blue);
        ObjectSet("BuyZeroLevel", OBJPROP_STYLE, DRAW_SECTION);
      }
      else ObjectSet("BuyZeroLevel", OBJPROP_PRICE1, AveragePrice);
      
      if(ObjectFind("BuyAveragePrice") == -1) 
      {
        ObjectCreate("BuyAveragePrice",OBJ_HLINE, 0, 0, AveragePrice + StaticTakeProfit*vPoint);
        ObjectSet("BuyAveragePrice", OBJPROP_COLOR, Blue);
        ObjectSet("BuyAveragePrice", OBJPROP_STYLE, DRAW_LINE);
      }
      else ObjectSet("BuyAveragePrice", OBJPROP_PRICE1, AveragePrice + StaticTakeProfit*vPoint);
    }    
  }
  //<_BUY
  
  //SELL
  PriceTarget = 0;
  AveragePrice = 0;
  TotalSellOrders = CountOfOrders(MagicNumberSell);
  if(TotalSellOrders > 0) 
  {
    PriceTarget = FindFirstOrderParameter(MagicNumberSell, "price") - StaticTakeProfit*vPoint;
    AveragePrice = CalculateAveragePrice(MagicNumberSell);
  }

  for (i = 0; i < OrdersTotal(); i++) 
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumberSell)
        if (NormalizeDouble(OrderTakeProfit(),vDigits) != NormalizeDouble(PriceTarget,vDigits)) ModifyTakeProfit(PriceTarget);
  
  if(DrawAveragePrice == true)
  {
    if(AveragePrice == 0)
    {
      if(ObjectFind("SellZeroLevel") != -1) ObjectDelete("SellZeroLevel");
      if(ObjectFind("SellAveragePrice") != -1) ObjectDelete("SellAveragePrice");
    }
    else
    {
      if(ObjectFind("SellZeroLevel") == -1) 
      {
        ObjectCreate("SellZeroLevel",OBJ_HLINE, 0, 0, AveragePrice);
        ObjectSet("SellZeroLevel", OBJPROP_COLOR, Red);
        ObjectSet("SellZeroLevel", OBJPROP_STYLE, DRAW_SECTION);
      }
      else ObjectSet("SellZeroLevel", OBJPROP_PRICE1, AveragePrice);

      if(ObjectFind("SellAveragePrice") == -1) 
      {
        ObjectCreate("SellAveragePrice",OBJ_HLINE, 0, 0, AveragePrice - StaticTakeProfit*vPoint);
        ObjectSet("SellAveragePrice", OBJPROP_COLOR, Red);
        ObjectSet("SellAveragePrice", OBJPROP_STYLE, DRAW_LINE);
      }
      else ObjectSet("SellAveragePrice", OBJPROP_PRICE1, AveragePrice - StaticTakeProfit*vPoint);
    }    
  }
  
  //<_SELL

}

//===================================================================================================================================================
//===================================================================================================================================================
double CalculateAveragePrice(int mNumber)
{
  double AveragePrice = 0;
  double Count = 0;
  for (int i = 0; i < OrdersTotal(); i++)
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == mNumber)
        if (OrderType() == OP_BUY  || OrderType() == OP_SELL) 
        {
           AveragePrice += OrderOpenPrice() * OrderLots();
           Count += OrderLots();
        }
  
  if(AveragePrice > 0 && Count > 0)
    return( NormalizeDouble(AveragePrice / Count, vDigits));
  else
    return(0);
}

//===================================================================================================================================================
//===================================================================================================================================================
int GetSignal()
{
  int Signal = 0;

  double iMA_Signal = iMA(Symbol(), 0, iMA_Period, 0, MODE_SMMA, PRICE_CLOSE, 0);
  
  int Ma_Bid_Diff = MathAbs(iMA_Signal - Bid)/vPoint;
  
  if(Ma_Bid_Diff > iMA_OpenDistance && Bid > iMA_Signal) Signal = -1;
  if(Ma_Bid_Diff > iMA_OpenDistance && Bid < iMA_Signal) Signal = 1;
  
  return(Signal);
}

//===================================================================================================================================================
//===================================================================================================================================================
int CountOfOrders(int mNumber)
{
  int count = 0;
  for (int i = 0; i < OrdersTotal(); i++) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber)) 
        if ((OrderType() == OP_SELL) || (OrderType() == OP_BUY)) 
          count++;
 
  return(count);
}

//===================================================================================================================================================
//===================================================================================================================================================
double GetLotForStep(int mNumber, int OrdCount)
{
  double CurrLot = 0;
  double LastOrderLot = FindLastOrderParameter(mNumber, "lot");

  if(UseAutoLot == true)
  {
    if(LastOrderLot != 0) CurrLot = NormalizeDouble(LastOrderLot + NormalizeDouble(AccountEquity() * AutoLotIncrement/10000, 2)*OrdCount, 2);
  }
  else
  {
    if(LastOrderLot != 0) CurrLot = NormalizeDouble(LastOrderLot + LotIncrement*OrdCount, 2);
  }
 
  // 
  if(CurrLot > MaxLot) CurrLot = MaxLot;
  if(CurrLot < StartLot) CurrLot = StartLot;
  
  if(CurrLot == 0) CurrLot = StartLot;
  
  return(CurrLot);
}

//===================================================================================================================================================
//===================================================================================================================================================
double GetStartLot()
{
  double FirstLot = 0;
  
  if(UseAutoLot == true)
  {
    FirstLot = NormalizeDouble(AccountEquity() * AutoLot/10000, 2);
  }
  else
  {
    FirstLot = StartLot;
  }
  
  if(FirstLot > MaxLot) FirstLot = MaxLot;
  if(FirstLot < StartLot) FirstLot = StartLot;
  
  return(FirstLot);
}

//===================================================================================================================================================
//===================================================================================================================================================
double GetPipstepForStep(int CurrStep)
{
  double CurrPipstep = NormalizeDouble(PipStep * MathPow(PipStepExponent,CurrStep), 0);
   
  return(CurrPipstep);
}

//===================================================================================================================================================
//===================================================================================================================================================
double FindFirstOrderParameter(int mNumber, string ParamName) 
{
  int mOrderTicket = 0;
  double mOrderPrice = 0;
  double mOrderLot = 0;
  double mOrderProfit = 0;
  int PrevTicket = 0;
  int CurrTicket = 0;
  for (i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == mNumber)
      {
        CurrTicket = OrderTicket();
        if (CurrTicket < PrevTicket || PrevTicket == 0)
        { 
          PrevTicket = CurrTicket;
          
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();
        }
      }
   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
}

//===================================================================================================================================================
//===================================================================================================================================================
double FindLastOrderParameter(int mNumber, string ParamName) 
{
  int mOrderTicket = 0;
  double mOrderPrice = 0;
  double mOrderLot = 0;
  double mOrderProfit = 0;
  int PrevTicket = 0;
  int CurrTicket = 0;

  for (i = OrdersTotal() - 1; i >= 0; i--) 
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) 
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == mNumber) 
      {
        CurrTicket = OrderTicket();
        if (CurrTicket > PrevTicket) 
        {
          PrevTicket = CurrTicket;
          
          mOrderPrice = OrderOpenPrice();
          mOrderTicket = OrderTicket();
          mOrderLot = OrderLots();
          mOrderProfit = OrderProfit() + OrderSwap() + OrderCommission();
          LastOrderComment = OrderComment();
        }
      }
   
  if(ParamName == "price") return(mOrderPrice);
  else if(ParamName == "ticket") return(mOrderTicket);
  else if(ParamName == "lot") return(mOrderLot);
  else if(ParamName == "profit") return(mOrderProfit);
}

//===================================================================================================================================================
//===================================================================================================================================================
double GetClosedProfit(int mNumber)
{
  double ClosedProfit = 0;
  
  for (i = OrdersHistoryTotal(); i > 0; i--) 
    if(OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == mNumber)
        if(StringSubstr(LastOrderComment, 0, StringFind(LastOrderComment, "|", 0)) == StringSubstr(OrderComment(), 0, StringFind(OrderComment(), "|", 0)))
          ClosedProfit = ClosedProfit + OrderProfit();

  return(ClosedProfit);
}

//===================================================================================================================================================
//===================================================================================================================================================
bool ModifyTakeProfit(double takeprofit)
{
  while(!IsStopped())
  {
    if(IsTradeContextBusy())
    {
      Sleep(3000);
      continue;
    }
    if(!IsTradeAllowed())
    {
      return(False);
    }
    if(!OrderModify(OrderTicket(), OrderOpenPrice(), 0, NormalizeDouble(takeprofit,vDigits), 0, Yellow))
    {
      int Err = GetLastError();
      Print("!!! Error(",Err,"): ",ErrorDescription(Err));
      return(False);
    }
    else
    {
      break;
    }
  }
  
  return(True);
}

//===================================================================================================================================================
//===================================================================================================================================================
int SendMarketOrder(int Type, double Lots, int TP, int SL, int Magic, string Cmnt, double OpenPrice = 0, string mSymbol = "")
{
  double Price, Take, Stop;
  int Ticket, Color, Err; 
  int ErrorCount = 0;
  while(!IsStopped())
  {
    if(ErrorCount > 5) return(0);
    if(!IsConnected())
    {
      ErrorCount = ErrorCount + 1;
      Print("No connection with server!");
      Sleep(1000);
    }
    if(IsTradeContextBusy())
    {
      Sleep(3000);
      continue;
    }
    switch(Type)
    {
      case OP_BUY:
        if(mSymbol == "")
          Price = NormalizeDouble(Ask, vDigits);
        else
          Price = NormalizeDouble(MarketInfo(mSymbol, MODE_ASK), vDigits);
        Take = IIFd(TP == 0, 0, NormalizeDouble( Price + TP * vPoint, vDigits));
        Stop = IIFd(SL == 0, 0, NormalizeDouble( Price - SL * vPoint, vDigits));
        Color = Blue;
        break;
      case OP_SELL:
        if(mSymbol == "")
          Price = NormalizeDouble( Bid, vDigits);
        else
          Price = NormalizeDouble(MarketInfo(mSymbol, MODE_BID), vDigits);
        Price = NormalizeDouble( Bid, Digits);
        Take = IIFd(TP == 0, 0, NormalizeDouble( Price - TP * vPoint, vDigits));
        Stop = IIFd(SL == 0, 0, NormalizeDouble( Price + SL * vPoint, vDigits));
        Color = Red;
        break;
      default:
        return(-1);
    }
    if(IsTradeAllowed())
    {
      if(mSymbol == "")
        Ticket = OrderSend(Symbol(), Type, Lots, Price, 2*Spread, 0, 0, Cmnt, Magic, 0, Color); // amended code   
//        Ticket = OrderSend(Symbol(), Type, Lots, Price, 2*Spread, Stop, Take, Cmnt, Magic, 0, Color); // original code for this line
      else
        Ticket = OrderSend(mSymbol, Type, Lots, Price, 2*Spread, Stop, Take, Cmnt, Magic, 0, Color);
      
      if(Ticket < 0)
      {
        Err = GetLastError();
        if (Err == 4   || /* SERVER_BUSY */
            Err == 129 || /* INVALID_PRICE */ 
            Err == 135 || /* PRICE_CHANGED */ 
            Err == 137 || /* BROKER_BUSY */ 
            Err == 138 || /* REQUOTE */ 
            Err == 146 || /* TRADE_CONTEXT_BUSY */
            Err == 136 )  /* OFF_QUOTES */
        {
          Sleep(3000);
          continue;
        }
        else
        {
          break;
        }
      }
      break;
    }
    else
    {
      break;
    }
  }

  return(Ticket);
}

//===================================================================================================================================================
//===================================================================================================================================================
double IIFd(bool condition, double ifTrue, double ifFalse) 
{
  if (condition) return(ifTrue); else return(ifFalse);
}

//===================================================================================================================================================
//===================================================================================================================================================
void DrawInfo()
{
  BuySummLot = 0; TotalProfitBuy = 0;
  for(i=OrdersTotal();i>=0;i--)
  {
    if (OrderSelect(i,SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == Symbol() && (OrderMagicNumber()==MagicNumberBuy)) 
    {
      BuySummLot += OrderLots(); 
      TotalProfitBuy += OrderProfit() + OrderCommission() + OrderSwap();
    }
  }
  double ClosedBuyProfit = GetClosedProfit(MagicNumberBuy);
  
  SellSummLot = 0; TotalProfitSell = 0;
  for(i=OrdersTotal();i>=0;i--)
  {
    if (OrderSelect(i,SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == Symbol() && (OrderMagicNumber()==MagicNumberSell)) 
    {
      SellSummLot += OrderLots(); 
      TotalProfitSell += OrderProfit() + OrderCommission() + OrderSwap();
    }
  }
  double ClosedSellProfit = GetClosedProfit(MagicNumberSell);
  
  Comment(
  "\n",
  ">>> BUY  Orders: ",TotalBuyOrders," lots: ",BuySummLot," Profit: ",TotalProfitBuy,
  "\n",">>> Profit Taken:",ClosedBuyProfit,"\n",
  "\n",
  ">>> SELL Orders: ",TotalSellOrders," lots: ",SellSummLot," Profit: ",TotalProfitSell,
  "\n",">>> Profit taken :", ClosedSellProfit
  );

}

//===================================================================================================================================================
//===================================================================================================================================================
void ShowCurrentTime()
{
  int min,sec;
  min = Time[0] + Period()*60 - CurTime();
  sec = min%60;
  min = (min - min%60)/60;
	
  if(ObjectFind("CurrTime") != 0)
    ObjectCreate("CurrTime", OBJ_TEXT, 0, Time[0], Close[0]);
  else
    ObjectMove("CurrTime", 0, Time[0], Close[0]);
 
  ObjectSetText("CurrTime", "                <" + min + ":" + sec, 14, "Verdana", Black);
}

//===================================================================================================================================================
//===================================================================================================================================================
void CheckOverlapping()
{
  //BUY--->
  TotalBuyOrders = CountOfOrders(MagicNumberBuy);
  if (TotalBuyOrders >= 2) 
  {
    Lpos = 0; Cpos = 0; Lprofit = 0; Cprofit = 0;
    Lpos = LidingProfitOrder(MagicNumberBuy);
    Cpos = CloseProfitOrder(MagicNumberBuy);
    
    if(Lprofit > 0 && Lprofit1 <= 0)
    {
      if(Lprofit + Cprofit > 0 && (Lprofit + Cprofit)*100/Lprofit > ProfitPersent) 
      {
        Lpos1 = 0;
        CloseSelectOrder(MagicNumberBuy); 
      }
    }
    else if(Lprofit > 0 && Lprofit1 > 0)
    {
      if(Lprofit + Lprofit1 + Cprofit > 0 && (Lprofit + Lprofit1 + Cprofit)*100/(Lprofit + Lprofit1) > SecondProfitPersent) CloseSelectOrder(MagicNumberBuy); 
    }
  } 
  //<---BUY

  //SELL--->
  TotalSellOrders = CountOfOrders(MagicNumberSell);
  if (TotalSellOrders >= 2) 
  {
    Lpos = 0; Cpos = 0; Lprofit = 0; Cprofit = 0;
    Lpos = LidingProfitOrder(MagicNumberSell);
    Cpos = CloseProfitOrder(MagicNumberSell);
       
    if(Lprofit > 0 && Lprofit1 <= 0)
    {
      if(Lprofit + Cprofit > 0 && (Lprofit + Cprofit)*100/Lprofit > ProfitPersent) 
      {
        Lpos1 = 0;
        CloseSelectOrder(MagicNumberSell); 
      }
    }  
    if(Lprofit > 0 && Lprofit1 > 0)
    {
      if(Lprofit + Lprofit1 + Cprofit > 0 && (Lprofit + Lprofit1 + Cprofit)*100/(Lprofit + Lprofit1) > SecondProfitPersent) CloseSelectOrder(MagicNumberSell); 
    }
  } 
  //<---SELL
}


//======================================== Most profitable order =======================================
int LidingProfitOrder(int mNumber) 
{
   Lprofit1 = 0;
   Lpos1 = 0;
   int TotalOrders = CountOfOrders(mNumber);
   double profit  = 0;
   int    Pos     = 0;
   for (i = 0; i < OrdersTotal(); i++) 
   {
       if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  
       {
          if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber))
          {
             if (OrderType() == OP_SELL || OrderType() == OP_BUY) 
             { 
                profit = OrderProfit();
                Pos    = OrderTicket();
                if (profit > 0 && profit > Lprofit) {
                   // Previous value
                   Lprofit1 = Lprofit;
                   Lpos1    = Lpos;

                   // Maximum value
                   Lprofit = profit;
                   Lpos    = Pos;
                }
             }
          }
       }   
   }    
   return (Lpos);
} 
//========================================  Least Profitable Order =======================================
int CloseProfitOrder(int mNumber) 
{
   double profit  = 0;
   int    Pos     = 0;
   for (int trade = OrdersTotal() - 1; trade >= 0; trade--) {
       if (OrderSelect(trade, SELECT_BY_POS, MODE_TRADES))  {
          if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber)){
             if (OrderType() == OP_SELL || OrderType() == OP_BUY) { 
                profit = OrderProfit();
                Pos    = OrderTicket();
                if (profit < 0 && profit < Cprofit) {
                   Cprofit = profit;
                   Cpos    = Pos;
                }
             }
          }
       }   
   }    
   return (Cpos);
}
//==========================================  Closing Orders ===============================================
int CloseSelectOrder(int mNumber)
{
  int error =  0;
  int error1 = 0;
  int error2 = 0;
  int Result = 0;
//                       ----------------------  Last Order -----------------------                            
       
  while (error1 == 0) 
  {
          RefreshRates();
            i = OrderSelect(Lpos, SELECT_BY_TICKET, MODE_TRADES);
            if  (i != 1 ) {
                Print ("Error! Not possible to select most profitable order . Operation cancelled.");
                return (0);
            }  
            if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber)) {
               if (OrderType() == OP_BUY) {
                  error1 =  (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), Spread, Blue));
                  if (error1 == 1) {
                     Print ("Leading Order closed successfully"); 
                     Sleep (500);   
                  } else {
                     Print ("Error closing leading order, Repeat Operation. ");                     
                  }      
               } 
//                        -----------------------------------------------------               
               if (OrderType() == OP_SELL) {
                  error1 = (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), Spread, Red));
                  if (error1 == 1) {
                     Print ("Leading Order closed successfully"); 
                     Sleep (500);   
                  } else {
                     Print ("Error closing leading order, Repeat Operation. ");                     
                  }
               }
            } 
      }

//                       ---------------------- Previous Last  -----------------------                            		
      if(Lpos1 != 0)
      {
      while (error2 == 0) {
            RefreshRates();
            i = OrderSelect(Lpos1, SELECT_BY_TICKET, MODE_TRADES);
            if  (i != 1 ) {
                Print ("Error! Not possible to select previous most profitable order . Operation cancelled.");
                return (0);
            }  
            if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber)) {
               if (OrderType() == OP_BUY) {
                  error2 =  (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), Spread, Blue));
                  if (error2 == 1) {
                     Print ("Previous leading order closed successfully");
                     Sleep (500);   
                  } else {
                     Print ("Error closing previous leading order, Repeat Operation. ");                     
                  }      
               } 
//                        -----------------------------------------------------               
               if (OrderType() == OP_SELL) {
                  error2 = (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), Spread, Red));
                  if (error2 == 1) {
                     Print ("Previous leading order closed successfully"); 
                     Sleep (500);   
                  } else {
                     Print ("Error closing previous leading order, Repeat Operation. ");                     
                  }
               }
            } 
      }
      }
//								----------- Selected (Least profitable order ) -----------
      while (error == 0) {
            RefreshRates();
            int i = OrderSelect(Cpos, SELECT_BY_TICKET, MODE_TRADES);
            if  (i != 1 ) {
                Print ("Error! Not possible to select least profitable order. Operation cancelled");
                return (0);
            }    
            if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == mNumber)) {
               if (OrderType() == OP_BUY) {
                  error = (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), Spread, Blue)); 
                  if (error == 1 ) {
                     Print ("Order closed successfully."); 
                     Sleep (500);   
                  } else {
                     Print ("Error during Order Close. Repeat operation.  ");                    
                  } 
               }        
//                             --------------------------------------------------                
               if (OrderType() == OP_SELL) {
                  error = (OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), Spread, Red));
                  if (error == 1) {
						Print ("Order closed successfully."); 
                     Sleep (500);   
                  } else {
						  Print ("Error during Order Close. Repeat operation.  ");                     
                  }
               }
            }
      }     
       
  Result = 1;
  return (Result);    
}   